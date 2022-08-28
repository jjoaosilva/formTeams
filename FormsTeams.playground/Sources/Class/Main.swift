import Foundation

protocol MainType {
    func getStudents() -> [Student]
    func addRelation(cycle: [[String]])
    func formNewCyle(teamLegth: Int) -> [[String]]
}

public class Main {
    private let dataBase: Cycle?
    private var students: [Student] = []

    public init(dataBase: Cycle?) {
        self.dataBase = dataBase

        if let cycle1 = dataBase?.ciclo1, let cycle2 = dataBase?.ciclo2 {
            createStudents(cycle: cycle1)
            addRelation(cycle: cycle2)
        }
    }

    // Create students based on cycle
    private func createStudents(cycle: [[String]]) {
        var id = 0

        // reduce [[String]] to [Student]
        students = cycle.reduce([], { partialResult, team in
            
            let step = team.count
            let teamIds: [Int] = Array(id..<(id+step))
            
            // transform [String] to [Student]
            let partialStudents: [Student] = team.map { studentName in
                
                // create relation between students based on first cycle
                var alreadyWork = teamIds
                alreadyWork.removeAll { studentID in
                    studentID == id
                }

                let student = Student(id: id,
                                      name: studentName,
                                      alreadyWork: alreadyWork)
                id += 1
                return student
            }

            return partialResult + partialStudents
        })
    }
    
    private func getIdsFromTeamNames(names: [String]) -> [Int] {
        var ids = [Int]()

        names.forEach { studentName in
            
            // find student by name
            let student = students.first { student in
                student.name == studentName
            }
            
            if let student = student {
                ids.append(student.id)
            }
        }

        return ids
    }
    
    private func createRelation(with ids: [Int]) {
        ids.forEach { studentID in
            
            let student = getStudentById(id: studentID)

            // get student if not nil and find his index
            if let student = student, let index = students.firstIndex(where: { $0 == student }) {

                // create relation between old and new relations
                var alreadyWork = Set(ids).union(student.alreadyWork)
                alreadyWork.remove(studentID)
                
                // update relations
                students[index].alreadyWork = Array(alreadyWork)
            }
        }
    }

    private func getStudentById(id: Int) -> Student? {
        let student = students.first { student in
            student.id == id
        }
        return student
    }

    private func findStudentToJoinATeam(team: [Int], availableIds: inout Set<Int>) -> Int? {
        for studentID in availableIds {
            let student = getStudentById(id: studentID)
            if let student = student {
                let studentRelations = Set(student.alreadyWork)
                let teamRelations = Set(team)
                
                let subtract = studentRelations.intersection(teamRelations)
                if subtract.count == 0 {
                    availableIds.remove(studentID)
                    return student.id
                }
            }
        }
    
        return nil
    }
}

extension Main: MainType {

    // return all students with their relations
    public func getStudents() -> [Student] {
        return students
    }
    
    // Add relations based on cycle
    public func addRelation(cycle: [[String]]) {
        cycle.forEach { team in
            let ids = getIdsFromTeamNames(names: team)
            createRelation(with: ids)
        }
    }
    
    public func formNewCyle(teamLegth: Int) -> [[String]] {
        
        let totalTeams = students.count / teamLegth
        var teamsIds = Array(repeating: [Int](), count: totalTeams)
        var availableIds = Set(0..<students.count)

        // init groups with one student
        for index in 0..<totalTeams {
            availableIds.remove(index)
            teamsIds[index].append(students[index].id)
        }

        // complete groups with other students
        for teamIndex in 0..<totalTeams {

            for _ in 1..<teamLegth {
                let student = findStudentToJoinATeam(team: teamsIds[teamIndex],
                                                     availableIds: &availableIds)

                if let student = student {
                    teamsIds[teamIndex].append(student)
                }
            }
        }
        
        var teams = [[String]]()
        
        // transform [[Int]] to [[String]]
        teamsIds.forEach { team in
            let teamNames = team.compactMap { id in
                getStudentById(id: id)?.name
            }
            teams.append(teamNames)
        }

        return teams
    }
}
