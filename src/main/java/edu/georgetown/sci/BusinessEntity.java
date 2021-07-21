/**
 * Author: "Jianan Su"
 * Copyright: 
 * Credits: ["Jianan Su"]
 * Email: "js4488@georgetown.edu"
 * Status: "Prototype"
 */

import org.web3j.crypto.CipherException;
import org.web3j.crypto.Credentials;
import org.web3j.crypto.WalletUtils;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.http.HttpService;
import java.io.IOException;

public class BusinessEntity {
	protected Web3j web3j;
	
	protected Credentials credential;
	
	public BusinessEntity(){}
	
	protected void connectToRemoteNode(String httpService){
		this.web3j = Web3j.build(new HttpService(httpService));
		try {
			//log.info("Connected to Ethereum client version: "+ this.web3j.web3ClientVersion().send().getWeb3ClientVersion());
			System.out.println("Connected to Ethereum client version: "+ this.web3j.web3ClientVersion().send().getWeb3ClientVersion());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	protected void loadCredential(String password, String pathToWalletFile){
		try {
			this.credential = WalletUtils.loadCredentials(password, pathToWalletFile);
			//log.info("Credentials loaded");
			System.out.println("Credentials loaded.");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (CipherException e) {
			e.printStackTrace();
		}
	}
	
	protected void shutdown(){
		this.web3j.shutdown();
		System.out.println("Web3j shut down...");
		System.out.println();
	}
	
}
