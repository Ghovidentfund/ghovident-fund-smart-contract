// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;

interface IGhovidentPool {
    //  State variables

    struct PoolInfo {
        address thisAddress;
        string name;
        string logoUri;
        string factSheetUri;
        uint256 risk;
        uint256 period;
        address assets;
        address fund;
        uint256 totalVolume;
    }

    struct MyPoolInfo {
        address thisAddress;
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

    function getPoolInfo() external view returns (PoolInfo memory poolInfo);

    function getMyPoolInfo(
        address _company
    ) external view returns (MyPoolInfo memory myPoolInfo);
}
