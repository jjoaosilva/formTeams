import Foundation

// Read database file
print("Reading dataBase...")

let manager = DataBaseManager()
let dataBase = manager.readDataBase()

// Execute tests
print("Executing tests...")

let classTest = TestRunner()
classTest.runTests(testClass: DataBaseManagerTests.self)

// Init execution
print("Running code...")

let main = Main(dataBase: dataBase)
main.getStudents()

let teams = main.formNewCyle(teamLegth: 2)

teams.enumerated().forEach { index, team
    print("Team \(index+1) \(team)")
}
