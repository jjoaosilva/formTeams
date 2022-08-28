import Foundation

extension Cycle {
    static func stub() -> Cycle {
        let ciclo1 = [
            [
                "Laura",
                "Pedro",
                "João",
                "Vinicius"
            ],
            [
                "Carlos",
                "Maria",
                "Leonardo",
                "Ana"
            ],
            [
                "Daniela",
                "Marcos",
                "Wesley",
                "Luiza"
            ],
            [
                "Daiane",
                "Felipe",
                "Teodoro",
                "Helena"
            ],
            [
                "Natalia",
                "Beatriz",
                "Eduardo",
                "Caio"
            ]
        ]
        
        let ciclo2 = [
            [
                "Teodoro",
                "Daiane",
                "Luiza"
            ],
            [
                "Carlos",
                "João",
                "Helena"
            ],
            [
                "Daniela",
                "Pedro",
                "Caio"
            ],
            [
                "Leonardo",
                "Maria",
                "Laura"
            ],
            [
                "Beatriz",
                "Marcos",
                "Vinicius"
            ],
            [
                "Natalia",
                "Felipe",
                "Eduardo"
            ],
            [
                "Ana",
                "Wesley"
            ]
        ]

        let stub = Cycle(ciclo1: ciclo1, ciclo2: ciclo2)
        return stub
    }
}
