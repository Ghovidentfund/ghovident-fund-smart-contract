// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;

interface IGhovidentPool {
    //  State variables

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

    function getPoolInfo(
        address _company
    ) external view returns (PoolInfo memory);
}
