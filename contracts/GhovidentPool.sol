// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interfaces/IERC20WithPermit.sol";
import "./interfaces/IGhovidentFund.sol";

contract GhovidentPool {
    // Pool state
    address public immutable factory;
    string public name; // pool name
    uint256 public totalInvestment;

    IERC20WithPermit public assetToken;
    IGhovidentFund public ghovidentFund;

    struct Company {
        // uint companyId;
        string name;
        address companyAddress;
        uint256 totalInvestment;
        uint256 totalEmployee;
        Employee[] employees;
    }

    struct Employee {
        // uint companyId;
        // uint employeeId;
        string name;
        address employeeAddress;
        // uint256 salary;
        uint256 joinDate;
        // uint256 contribution;
        uint256 totalPay;
    }

    // uint public emplaoyeeId = 0;
    // uint public companyId = 0;
    mapping(address => Company) public allCompanies;
    mapping(address => Employee) public allEmployees;

    constructor(
        address _factory,
        string memory _name,
        address _assetToken,
        address _ghovidentFund
    ) {
        factory = _factory;
        name = _name;
        assetToken = IERC20WithPermit(_assetToken);
        ghovidentFund = IGhovidentFund(_ghovidentFund);
    }

    // https://stackoverflow.com/questions/72573064/push-data-into-a-nested-struct-array
    // create function to add company and employee
    function registerCompany(
        string memory _name,
        string[] calldata _employeeNames,
        address[] calldata _employeeAddresses,
        uint256[] calldata _employeeJoinDates,
        uint256[] calldata _employeeTotalPays
    ) external {
        Company storage company = allCompanies[msg.sender];
        company.name = _name;
        company.companyAddress = msg.sender;
        company.totalInvestment = 0;
        company.totalEmployee = 0;

        for (uint i = 0; i < _employeeNames.length; i++) {
            Employee storage employee = allEmployees[_employeeAddresses[i]];

            employee.name = _employeeNames[i];
            employee.employeeAddress = _employeeAddresses[i];
            employee.joinDate = _employeeJoinDates[i];
            employee.totalPay = _employeeTotalPays[i];
            company.totalEmployee++;
            company.employees.push(employee);
            totalInvestment += _employeeTotalPays[i];
        }

        // TODO: require balance of assetToken is enough
        assetToken.transferFrom(msg.sender, address(this), totalInvestment);

        allCompanies[msg.sender] = company;
    }

    //

    // setters
    function setName(string memory _name) external {
        name = _name;
    }

    // getters
    function getName() external view returns (string memory) {
        return name;
    }

    function getCompany(
        address _companyAddress
    ) external view returns (Company memory) {
        return allCompanies[_companyAddress];
    }
}
