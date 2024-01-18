import hre, { ethers } from "hardhat";
import addressUtils from "../../utils/addressUtils";

export async function deployLock() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const unlockTime = currentTimestampInSeconds + 60;

  const lockedAmount = ethers.parseEther("0.0001");

  const lock = await ethers.deployContract("Lock", [unlockTime], {
    value: lockedAmount,
  });

  await lock.waitForDeployment();

  await addressUtils.saveAddresses(hre.network.name, {
    Lock: await lock.getAddress(),
  });

  console.log(
    `Lock with ${ethers.formatEther(
      lockedAmount
    )}ETH and unlock timestamp ${unlockTime} deployed to ${lock.target}`
  );
}
