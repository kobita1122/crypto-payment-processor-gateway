const { ethers } = require("ethers");

const RPC_URL = "https://polygon-rpc.com";
const CONTRACT_ADDRESS = "0xYourContractAddressHere";
const ABI = [
    "event PaymentSent(address indexed customer, uint256 amount, uint256 indexed paymentId, address token)"
];

async function startListener() {
    const provider = new ethers.JsonRpcProvider(RPC_URL);
    const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);

    console.log("Listening for blockchain payments...");

    contract.on("PaymentSent", (customer, amount, paymentId, token) => {
        console.log(`
            --- New Payment Detected ---
            Customer: ${customer}
            Amount: ${ethers.formatEther(amount)}
            Payment ID: ${paymentId.toString()}
            Token Address: ${token === ethers.ZeroAddress ? "Native" : token}
        `);
        
        // Here you would trigger your database update or API callback
    });
}

startListener().catch(console.error);
