// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;

interface IGhovidentFactory {
    struct Company {
        string name;
        address companyAddress;
        string _infoUri;
        // uint256 totalInvestment;
        // uint256 totalEmployee;
    }

    struct PoolInfo {
        string name;
        string logoUri;
        string factSheetUri;
        uint256 risk;
        uint256 period;
        address assets;
        address fund;
        uint256 totalVolume;
        uint256 volume;
    }

    event PoolCreated(address pool, address owner);

    // State variables
    function pools(uint256) external view returns (address);

    function poolCount() external view returns (uint256);

    function companyCount() external view returns (uint256);

    function allCompany(
        uint256
    ) external view returns (string memory, address, string memory);

    function company(
        address
    ) external view returns (string memory, address, string memory);

    // Write functions
    function createPool(
        string memory _name,
        address _assets,
        address _fund,
        string memory _logoUri,
        string memory _factSheetUri,
        uint256 _risk,
        uint256 _period
    ) external;

    function createCompany(
        string memory _name,
        string memory _infoUri
    ) external;

    // Read functions
    function getAllPools() external view returns (address[] memory);

    function getAllCompany() external view returns (Company[] memory);

    function investIn(address _company, address _pool) external;
}
