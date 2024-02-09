// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// School Registration, a CRUD operation
contract StudentRegistry {
    address public owner;

    // Student Structure
    struct Student {
        string name;
        uint age;
        string rollNumber;
        bool exists;
    }

    mapping(address => Student) public students;

    // only priciple can perform this action
    modifier principle() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Student Registration Records
    function registerStudent(
        address _studentAddress,
        string memory _name,
        uint _age,
        string memory _rollNumber
    ) public principle {
        require(
            !students[_studentAddress].exists,
            "Student already registered"
        );

        Student memory newStudent = Student({
            name: _name,
            age: _age,
            rollNumber: _rollNumber,
            exists: true
        });

        students[_studentAddress] = newStudent;
    }

    // Student Update Records
    function updateStudent(
        address _studentAddress,
        string memory _name,
        uint _age,
        string memory _rollNumber
    ) public principle {
        require(students[_studentAddress].exists, "Student not registered");

        students[_studentAddress].name = _name;
        students[_studentAddress].age = _age;
        students[_studentAddress].rollNumber = _rollNumber;
    }

    // Student Deletion Records
    function deleteStudent(address _studentAddress) public principle {
        require(students[_studentAddress].exists, "Student not registered");

        delete students[_studentAddress];
    }

    // Get Student Details
    function getStudent(
        address _studentAddress
    ) public view returns (string memory, uint, string memory) {
        require(students[_studentAddress].exists, "Student not registered");

        return (
            students[_studentAddress].name,
            students[_studentAddress].age,
            students[_studentAddress].rollNumber
        );
    }

}
