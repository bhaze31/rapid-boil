import XCTest
@testable import rapid_boil

final class FieldTests: XCTestCase {
    func testDictionaryField() throws {
        var dict = Field(
            name: "test",
            type: "dict",
            keyType: "string",
            valueType: "User"
        )
        
        var swiftType = dict.getSwiftType()
        
        XCTAssertEqual(swiftType, "Dictionary<String, User>")
        
        dict = Field(
            name: "test",
            type: "dict",
            isArray: true,
            keyType: "string",
            valueType: "double"
        )
        
        swiftType = dict.getSwiftType()
        
        XCTAssertEqual(swiftType, "[Dictionary<String, Double>]")
        
        dict = Field(
            name: "test",
            type: "dict",
            isOptional: true,
            keyType: "string",
            valueType: "dict"
        )
        
        swiftType = dict.getSwiftType()
        
        XCTAssertEqual(swiftType, "Dictionary<String, Any>?")
        
        dict = Field(
            name: "test",
            type: "dict",
            isOptional: true,
            isArray: true,
            keyType: "int",
            valueType: "string"
        )
        
        swiftType = dict.getSwiftType()
        
        XCTAssertEqual(swiftType, "[Dictionary<Int, String>]?")
    }
    
    func testStringField() throws {
        let string = Field(
            name: "test",
            type: "string"
        )
        
        var swiftType = string.getSwiftType()
        
        XCTAssertEqual(swiftType, "String")
        
        let stringArray = Field(
            name: "test",
            type: "string",
            isArray: true
        )
        
        swiftType = stringArray.getSwiftType()
        
        XCTAssertEqual(swiftType, "[String]")
        
        let stringOptional = Field(
            name: "test",
            type: "string",
            isOptional: true
        )
        
        swiftType = stringOptional.getSwiftType()
        
        XCTAssertEqual(swiftType, "String?")
        
        let stringOptionalArray = Field(
            name: "test",
            type: "string",
            isOptional: true,
            isArray: true
        )
        
        swiftType = stringOptionalArray.getSwiftType()
        
        XCTAssertEqual(swiftType, "[String]?")
    }
    
    func testExtractFieldsData() throws {
        let passedFields = [
            "field1:string",
            "field2:int:o",
            "field3:double.a:optional",
            "field4:bool.array",
            "field5:dict.a|string|int:o"
            
        ]
        
        let fields = extractFieldsData(fields: passedFields)
        
        XCTAssertEqual(fields.count, 5)
        
        
        // TODO: Test all fields
        var field = fields[0]
        
        XCTAssertEqual(field.name, "field1")
        XCTAssertEqual(field.type, "string")
        XCTAssertEqual(field.isOptional, false)
        XCTAssertEqual(field.isArray, false)
        
        field = fields[1]
        
        XCTAssertEqual(field.name, "field2")
        XCTAssertEqual(field.type, "int")
        XCTAssertEqual(field.isOptional, true)
        XCTAssertEqual(field.isArray, false)
        
        field = fields[2]
        
        XCTAssertEqual(field.name, "field3")
        XCTAssertEqual(field.type, "double")
        XCTAssertEqual(field.isOptional, true)
        XCTAssertEqual(field.isArray, true)
        
        field = fields[3]
        
        XCTAssertEqual(field.name, "field4")
        XCTAssertEqual(field.type, "bool")
        XCTAssertEqual(field.isOptional, false)
        XCTAssertEqual(field.isArray, true)

        field = fields[4]
        
        XCTAssertEqual(field.name, "field5")
        XCTAssertEqual(field.type, "dict")
        XCTAssertEqual(field.isOptional, true)
        XCTAssertEqual(field.isArray, true)
        XCTAssertEqual(field.keyType, "string")
        XCTAssertEqual(field.valueType, "int")
    }
}
