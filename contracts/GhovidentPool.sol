// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interfaces/IERC20WithPermit.sol";
import "./interfaces/IGhovidentFund.sol";
import "./interfaces/IGhovidentPool.sol";
import "./interfaces/IGhovidentFactory.sol";

contract GhovidentPool is IGhovidentPool {
    address public immutable factory;

    string public name;
    string public logoUri;
    string public factSheetUri;
    uint256 public risk; // 1 = low, 2 = monderate, 3 = high , 4 = very high
    uint256 public period; // 0 = 1M, 1 = 3M, 2 = 6M, 3 = 12M
    address public assets; // address of token
    address public fund;

    IERC20WithPermit private _token;
    IGhovidentFactory private _ghovidentFactory;
    IGhovidentFund private _ghovidentFund;

    uint256 public totalVolume;

    mapping(address => uint256) public volumeOf; // volume of each company

    constructor(
        address _factory,
        string memory _name,
        string memory _logoUri,
        string memory _factSheetUri,
        uint256 _risk,
        uint256 _period,
        address _assets,
        address _fund
    ) {
        factory = _factory;
        name = _name;
        logoUri = _logoUri;
        factSheetUri = _factSheetUri;
        risk = _risk;
        period = _period;
        assets = _assets;
        fund = _fund;

        _token = IERC20WithPermit(_assets);
        _ghovidentFactory = IGhovidentFactory(_factory);
        _ghovidentFund = IGhovidentFund(_fund);
    }

    function supply(uint256 amount) public {
        require(amount <= _token.balanceOf(msg.sender), "Not enough balance");
        _token.transferFrom(msg.sender, address(this), amount);
        totalVolume += amount;
        volumeOf[msg.sender] += amount;
        _ghovidentFactory.investIn(msg.sender, address(this));
        _token.approve(address(_ghovidentFund), amount);
        _ghovidentFund.supply(assets, address(this), amount);
    }

    function withdraw() public {
        uint256 amount = volumeOf[msg.sender];
        require(amount <= volumeOf[msg.sender], "Not enough balance");
        _ghovidentFund.withdraw(assets, msg.sender, amount);
        totalVolume -= amount;
        volumeOf[msg.sender] -= amount;
    }

    function getPoolInfo() external view returns (PoolInfo memory) {
        return
            PoolInfo(
                name,
                logoUri,
                factSheetUri,
                risk,
                period,
                assets,
                fund,
                totalVolume
            );
    }

    function getMyPoolInfo(
        address _company
    ) external view returns (MyPoolInfo memory) {
        return
            MyPoolInfo(
                name,
                logoUri,
                factSheetUri,
                risk,
                period,
                assets,
                fund,
                totalVolume,
                volumeOf[_company]
            );
    }
}
