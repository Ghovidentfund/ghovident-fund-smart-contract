// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./GhovidentPool.sol";
import "./interfaces/IGhovidentFactory.sol";
import "./interfaces/IGhovidentPool.sol";

contract GhovidentFactory is IGhovidentFactory {
    // State
    address[] public pools;
    uint256 public poolCount = 0;

    uint256 public companyCount = 0;
    Company[] public allCompany;
    mapping(address => Company) public company;

    // 0x123 -> [0x456, 0x789]
    mapping(address => uint) public investCount;
    mapping(address => address[]) public inverstAllIn;

    function createPool(
        string memory _name,
        address _assets,
        address _fund,
        string memory _logoUri,
        string memory _factSheetUri,
        uint256 _risk,
        uint256 _period
    ) external {
        address pool = address(
            new GhovidentPool(
                address(this),
                _name,
                _logoUri,
                _factSheetUri,
                _risk,
                _period,
                _assets,
                _fund
            )
        );
        pools.push(pool);
        poolCount += 1;
        emit PoolCreated(pool, msg.sender);
    }

    function createCompany(
        string memory _name,
        string memory _infoUri
    ) external {
        companyCount += 1;
        allCompany.push(Company(_name, msg.sender, _infoUri));
        company[msg.sender] = Company(_name, msg.sender, _infoUri);
    }

    // getters
    function getAllPools() external view returns (address[] memory) {
        return pools;
    }

    function getAllCompany() external view returns (Company[] memory) {
        return allCompany;
    }

    function getInvestAllIn(
        address _company
    ) external view returns (address[] memory) {
        return inverstAllIn[_company];
    }

    function investIn(address _company, address _pool) external {
        inverstAllIn[_company].push(_pool);
        investCount[_company] += 1;
    }

    function getMyPools(address _company) public view {
        address[] memory _pools = inverstAllIn[_company];
        IGhovidentPool.PoolInfo[]
            memory _poolInfos = new IGhovidentPool.PoolInfo[](_pools.length);
        for (uint i = 0; i < _pools.length; i++) {
            _poolInfos[i] = IGhovidentPool(_pools[i]).getPoolInfo(_company);
        }
    }
}
