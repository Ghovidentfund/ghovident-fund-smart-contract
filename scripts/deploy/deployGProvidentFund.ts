import hre, { ethers } from "hardhat";
import addressUtils from "../../utils/addressUtils";

export async function deployGProvidentFund() {
  const aavePool = "0x0562453c3dafbb5e625483af58f4e6d668c44e19";
  const aaveToken = "0x88541670E55cC00bEEFD87eB59EDd1b7C511AC9a";
  const gProvidentFund = await ethers.deployContract("GProvidentFund", [
    aavePool,
    aaveToken,
  ]);
  await gProvidentFund.waitForDeployment();

  await addressUtils.saveAddresses(hre.network.name, {
    GProvidentFund: await gProvidentFund.getAddress(),
  });
}
