import Foundation
import XCTest

public class DataBaseManagerTests: XCTestCase {

    var sut: DataBaseManager!

    public override func setUp() {
        sut = DataBaseManager()
    }

    func test_readDataBase_whenUseDefaultName_returnNotNilValue() {
        let capturedValue = sut.readDataBase()

        XCTAssertNotNil(capturedValue, "should return not nil value")
    }

    func test_readDataBase_whenUseDefaultName_returnDecodeCorrectly() {
        let capturedValue = sut.readDataBase()
        let expectedValue = Cycle.stub()
    
        XCTAssertEqual(capturedValue, expectedValue, "should decode correctly")
    }

    func test_readDataBase_whenUseIncorrectJasonName_returnDecodeCorrectly() {
        let capturedValue = sut.readDataBase(name: "errorName")
    
        XCTAssertNil(capturedValue, "should return nil")
    }
}
