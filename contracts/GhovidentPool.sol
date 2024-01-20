// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./GhovidentDeployer.sol";
import "./interfaces/IGhovidentPool.sol";
import "./interfaces/IGhovidentInvestment.sol";
import "./interfaces/IGhovidentDeployer.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IERC20WithPermit.sol";

contract GhovidentPool is IGhovidentPool, Ownable {
    address public factory;
    string public name;
    address public assetes; // token support
    IGhovidentDeployer.RiskLevel public risk;
    uint256 public period;
    string public link;
    address public fundAddress;
    bool public status;

    IGhovidentInvestment private _fundAddress;
    IERC20WithPermit public assetesToken;

    uint public totalStaked;
    mapping(address => uint) public balances;

    // บริษัทมากฝากเงินใน pool
    // ซึ่งใน pool มันจะลงทุนที่ GProvidentFund ที่เดียว!
    // stake -> โอนเงินให้ GProvidentFund -> AavePool

    constructor() Ownable(msg.sender) {
        (
            factory,
            name,
            assetes,
            risk,
            period,
            link,
            fundAddress
        ) = IGhovidentDeployer(msg.sender).poolParameters();
        _fundAddress = IGhovidentInvestment(fundAddress);
        assetesToken = IERC20WithPermit(assetes);
    }

    function stake(uint256 amount) external override {
        // ! approve ghovidentFund to spend amount from ghovidentPool
        assetesToken.approve(address(_fundAddress), amount);
        assetesToken.transferFrom(msg.sender, address(this), amount);
        totalStaked += amount;
        balances[msg.sender] += amount;
        _fundAddress.stake(address(this), amount);

        // AaveToken approve pool , msg.sender
        // AvveToken approve avvePool , pool
    }

    function loan() external override {
        _fundAddress.loan();
    }

    function getPoolInfo()
        external
        view
        override
        returns (
            string memory,
            address,
            IGhovidentDeployer.RiskLevel,
            uint256,
            string memory,
            address,
            bool
        )
    {
        return (name, assetes, risk, period, link, fundAddress, status);
    }

    function setPoolStatus(bool _status) external onlyOwner {
        status = _status;
    }
}
