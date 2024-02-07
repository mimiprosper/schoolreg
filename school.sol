//SPDX-License-Identifier: UNLICENSED
pragma solidity "0.8.19";

contract StudentRegister {
    address public owner;

    mapping(address => student) students;

    constructor() {
        owner = msg.sender;
    }

    modifier principle() {
        require(msg.sender == owner);
        _;
    }

    struct student {
        address studentId;
        string name;
        string course;
        uint256 mark1;
        uint256 mark2;
        uint256 mark3;
        uint256 totalMarks;
        uint256 percentage;
        bool isExist;
    }

    function register(
        address studentId,
        string memory name,
        string memory course,
        uint256 mark1,
        uint256 mark2,
        uint256 mark3
    ) public principle {
        require(
            students[studentId].isExist == false,
            "ha.. ha... Fraud Not Possible,student details already registered and cannot be altered"
        );

        uint256 totalMarks;
        uint256 percentage;

        students[studentId] = student(
            studentId,
            name,
            course,
            mark1,
            mark2,
            mark3,
            totalMarks,
            percentage,
            true
        );
    }

    function getStudentDetails(
        address studentId
    )
        public
        view
        returns (address, string memory, string memory, uint256, uint256)
    {
        return (
            students[studentId].studentId,
            students[studentId].name,
            students[studentId].course,
            students[studentId].totalMarks,
            students[studentId].percentage
        );
    }
}
