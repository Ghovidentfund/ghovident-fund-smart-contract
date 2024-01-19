// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interfaces/IGhovidentCompanyPool.sol";
import "./interfaces/IGhovidentDeployer.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GhovidentCompanyPool is IGhovidentCompanyPool {
    address public immutable override factory;

    string public name;
    string public email;
    string public country;
    address public company;
    string public link;
    uint256 public createdAt;

    // mapping for employees
    mapping(address => Employee) public employees;

    constructor() {
        (
            factory,
            name,
            email,
            country,
            company,
            link,
            createdAt
        ) = IGhovidentDeployer(msg.sender).companyParameters();
    }

    // function batch create employee
    function batchCreateEmployee(
        address[] memory _employeeAddress,
        string[] memory _name,
        uint256[] memory _createdAt,
        uint256[] memory _defindContribution,
        uint256[] memory _balance,
        uint256[] memory _salary
    ) external override {
        for (uint256 i = 0; i < _employeeAddress.length; i++) {
            employees[_employeeAddress[i]] = Employee(
                _name[i],
                _employeeAddress[i],
                _createdAt[i],
                _defindContribution[i],
                _balance[i],
                _salary[i],
                true
            );
            emit EmployeeCreated(
                _employeeAddress[i],
                _name[i],
                _createdAt[i],
                _defindContribution[i],
                _balance[i],
                _salary[i]
            );
        }
    }

    // function to get employee info
    function getEmployeeInfo(
        address _employeeAddress
    )
        external
        view
        returns (
            string memory,
            address,
            uint256,
            uint256,
            uint256,
            uint256,
            bool
        )
    {
        Employee memory employee = employees[_employeeAddress];
        return (
            employee.name,
            employee.employeeAddress,
            employee.createdAt,
            employee.defindContribution,
            employee.balance,
            employee.salary,
            employee.status
        );
    }

    // function update employee info
    function updateEmployeeInfo(
        address _employeeAddress,
        string memory _name,
        uint256 _createdAt,
        uint256 _defindContribution,
        uint256 _balance,
        uint256 _salary,
        bool _status
    ) external {
        employees[_employeeAddress] = Employee(
            _name,
            _employeeAddress,
            _createdAt,
            _defindContribution,
            _balance,
            _salary,
            _status
        );
    }
}
