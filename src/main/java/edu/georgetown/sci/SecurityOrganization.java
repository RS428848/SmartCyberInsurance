/**
 * Author: "Jianan Su"
 * Copyright: 
 * Credits: ["Jianan Su"]
 * Email: "js4488@georgetown.edu"
 * Status: "Prototype"
 */

/***
 * import edu.georgetown.sci.contracts.generated.SIManagment4_1, generated source by Maven plugin
 *
 */

import edu.georgetown.sci.contracts.generated.SIManagement;

import org.web3j.tx.gas.ContractGasProvider;
import org.web3j.tx.gas.DefaultGasProvider;


public class SecurityOrganization extends BusinessEntity{
	protected SIManagement contract;
	
	public SecurityOrganization(){}
	
	protected void connectToRemoteNode(String httpService){
		System.out.println("Security Orgsnization...");
		super.connectToRemoteNode(httpService);
	}
	
	protected void loadCredential(String password, String pathToWalletFile){
		super.loadCredential(password, pathToWalletFile);
	}
	
	protected void loadContract(String contractAddress){
		ContractGasProvider contractGasProvider = new DefaultGasProvider();
        this.contract = SIManagement.load(contractAddress, super.web3j, super.credential, contractGasProvider); 
        System.out.println("Contract address: " + contract.getContractAddress());
	}
	
	protected void storeSecurityInforToBlockchain(String cveID, String vendorName, String productName, String versionAffected, String impactScore, String timeStamp){
		byte[] byteValue = cveID.getBytes();
        byte[] byteValueLen32 = new byte[32];
        System.arraycopy(byteValue, 0, byteValueLen32, 0, byteValue.length);
        try {
			this.contract.creatProduct(byteValueLen32, vendorName, productName, versionAffected, impactScore, timeStamp).send();
			System.out.println("Value stored in remote smart contract.");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	protected void setup(){
		this.connectToRemoteNode("http://172.16.145.164:8543");
		this.loadCredential("account_password", "/Users/js4488/keystore/UTC--2018-12-03T18-59-35.267788741Z--059bb1d4b9fbca8145be2c6d3d5f3b062a85badf");
		this.loadContract("0x1389A0bC7a75CC4aef0971B2240EFC6E045bF450");
	}
	
	
	public static void main(String[] args){
		//BasicConfigurator.configure();
		SecurityOrganization NIST = new SecurityOrganization();
		NIST.setup();
		NIST.storeSecurityInforToBlockchain("CVE-2019-1", "debian", "debian_linux", "8.0", "5.9", "08/01/2019");
		NIST.storeSecurityInforToBlockchain("CVE-2019-2", "libexpat", "expat", "1.95.1", "3.6", "08/02/2019");
		NIST.storeSecurityInforToBlockchain("CVE-2019-2", "canonical", "ubuntu_linux", "12.04", "3.6", "08/02/2019");
		NIST.storeSecurityInforToBlockchain("CVE-2019-2", "google", "android", "4.4.4", "3.6", "08/02/2019");
		NIST.storeSecurityInforToBlockchain("CVE-2019-2", "google", "android", "5.0.2", "3.6", "08/02/2019");
		NIST.storeSecurityInforToBlockchain("CVE-2019-2", "google", "android", "6.0.1", "3.6", "08/02/2019");
		NIST.shutdown();
		
	}
}
