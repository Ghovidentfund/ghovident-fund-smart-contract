// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interfaces/IGhovidentPool.sol";
import "./interfaces/IGhovidentDeployer.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GhovidentPool is IGhovidentPool {
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
        ) = IGhovidentDeployer(msg.sender).parameters();
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
                _salary[i]
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
}
