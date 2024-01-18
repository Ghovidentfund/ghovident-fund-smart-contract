// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IGhovidentPool {
    event EmployeeCreated(
        address indexed employeeAddress,
        string name,
        uint256 createdAt,
        uint256 defindContribution,
        uint256 balance
    );

    struct Employee {
        string name;
        address employeeAddress;
        uint256 createdAt;
        uint256 defindContribution;
        uint256 balance;
    }

    function factory() external view returns (address);

    function batchCreateEmployee(
        address[] memory _employeeAddress,
        string[] memory _name,
        uint256[] memory _createdAt,
        uint256[] memory _defindContribution,
        uint256[] memory _balance
    ) external;
}
