// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IGhovidentPool {
    event EmployeeCreated(
        address indexed employeeAddress,
        string name,
        uint256 createdAt,
        uint256 defindContribution,
        uint256 balance,
        uint256 salary
    );

    struct Employee {
        string name;
        address employeeAddress;
        uint256 createdAt;
        uint256 defindContribution;
        uint256 balance;
        uint256 salary;
        bool status;
    }

    function factory() external view returns (address);

    function name() external view returns (string memory);

    function email() external view returns (string memory);

    function country() external view returns (string memory);

    function company() external view returns (address);

    function link() external view returns (string memory);

    function createdAt() external view returns (uint256);

    function batchCreateEmployee(
        address[] memory _employeeAddress,
        string[] memory _name,
        uint256[] memory _createdAt,
        uint256[] memory _defindContribution,
        uint256[] memory _balance,
        uint256[] memory _salary
    ) external;
}
