pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;

contract SIManagement{
    
    //Product struct to hold vulnerable product information
    struct Product{
        bytes32 ID; // ID is the CVE number, e.g. CVE-2018-20650
        string vendorName;
        string productName;
        string versionValueAffected;
    }
    
    mapping(bytes32 => Product[]) public Products; // mapping from CVE number to its vendors data
    
    //Reference struct to hold reference information of each CVE 
    struct Reference{
        bytes32 ID; 
        string url;
        string name;
        string refsource;
        string tags;
    }
    
    mapping(bytes32 => Reference[]) public References; // mapping from CVE number to its references data
    
    //Impact struct to hold impact infor of each CVE
    struct Impact{
        bytes32 ID;
        string metric;
        string attackVector;
        string baseScore;
        string baseSeverity;
    }
    
    mapping(bytes32 => Impact[]) public Impacts; // mapping from CVE number to its impacts data

    
    // Time struct to hold time infor of each CVE
    struct Time{
        bytes32 ID;
        //string problemType;
        string publishDate;
        string lastModifyDate;
    }
    
    mapping(bytes32 => Time) public TimeStamp; // mapping from CVE number to its time stamp
    
    /**
     * @dev creat prudoct data for each vendor
     * @param _ID bytes32 represents CVE number
     * @param _vendorName string represents vulnerable vendor name
     * @param _productName string represents vulnerable product name of the vendor
     * @param _versionValueAffected string represents vulnerable version of the product
     */
    function creatProduct(bytes32 _ID, string memory _vendorName, string memory _productName, string memory _versionValueAffected) public{
        Product memory newProduct;
        newProduct.ID = _ID;
        newProduct.vendorName = _vendorName;
        newProduct.productName = _productName;
        newProduct.versionValueAffected = _versionValueAffected;
        
        creatProds(_ID, newProduct);

    }
    
    /**
     * @dev create an array of vulnerable product data for each CVE
     * @param _ID bytes32 represents CVE number
     * @param _newProduct struct represents one of vulnerable products data of the CVE
     */
    function creatProds(bytes32 _ID, Product memory _newProduct) public{
        Products[_ID].push(_newProduct);
    }
    
    /**
     * @dev get one of vulnerable products data of the CVE
     * @param _ID bytes32 represents CVE number
     * @param i uint represents the index of the product in the array of all products
     */
    function getProduct(bytes32 _ID, uint i) public returns(bytes32, string memory, string memory, string memory){
        Product memory p = Products[_ID][i];
        return(p.ID, p.vendorName, p.productName, p.versionValueAffected);
    }
    
    /**
     * @dev create reference data
     * @param _ID bytes32 represents CVE number
     * @param _url string represents url of the reference
     * @param _name string represents name of the reference
     * @param _refsource string represents source of the reference
     * @param _tags array string represents tags of the reference
     */
    function creatReference(bytes32 _ID, string memory _url, string memory _name, string memory _refsource, string memory _tags) public{
        Reference memory newReference;
        newReference.ID = _ID;
        newReference.url = _url;
        newReference.name = _name;
        newReference.refsource = _refsource;
        newReference.tags = _tags;
        
        creatRefs(_ID, newReference);
        
    }
    
    
     /**
     * @dev create an array of reference data for each CVE
     * @param _ID bytes32 represents CVE number
     * @param _newReference struct represents one of reference data of the CVE
     */
    function creatRefs(bytes32 _ID, Reference memory _newReference) public{
        References[_ID].push(_newReference);
        
    }
    
    /**
     * @dev get one of references data of the CVE
     * @param _ID bytes32 represents CVE number
     * @param i uint represents the index of the reference in the array of all references
     */
    function getReference(bytes32 _ID, uint i) public returns(bytes32, string memory, string memory, string memory, string memory){
        Reference memory r = References[_ID][i];
        return(r.ID, r.url, r.name, r.refsource, r.tags);
    }
    
    /**
     * @dev create Impact data
     * @param _ID bytes32 represents CVE number
     * @param _metric string represents metric type
     * @param _attackVector string represents attack vector
     * @param _baseScore string represents base score
     * @param _baseSeverity string represents base severity
     */
    function creatImpact(bytes32 _ID, string memory _metric, string memory _attackVector, string memory _baseScore, string memory _baseSeverity) public{
        Impact memory newImpact;
        newImpact.ID = _ID;
        newImpact.metric = _metric;
        newImpact.attackVector = _attackVector;
        newImpact.baseScore = _baseScore;
        newImpact.baseSeverity = _baseSeverity;
        
        creatImpacts(_ID, newImpact);
        
    }
    
    /**
     * @dev create an array of impacts data for each CVE
     * @param _ID bytes32 represents CVE number
     * @param _newImpact Impact struct represents one of impact data of the CVE
     */
    function creatImpacts(bytes32 _ID, Impact memory _newImpact) public{
        Impacts[_ID].push(_newImpact);
    }
    
    /**
     * @dev get one of impacts data of the CVE
     * @param _ID bytes32 represents CVE number
     * @param i uint represents the index of the impact in the array of all impacts
     */
    function getImpact(bytes32 _ID, uint i) public returns(bytes32, string memory, string memory, string memory, string memory){
        Impact memory i = Impacts[_ID][i];
        return(i.ID, i.metric, i.attackVector, i.baseSeverity, i.baseScore);
    }
    
    /**
     * @dev creat time stamp for each CVE
     * @param _ID bytes32 represents CVE number
     * @param _publishDate string represents published date of the CVE
     * @param _lastModifyDate string represents modified date of the CVE
     */
    function creatCVE(bytes32 _ID, string memory _publishDate, string memory _lastModifyDate) public{
        Time memory newTime;
        newTime.ID = _ID;
        newTime.publishDate = _publishDate;
        newTime.lastModifyDate = _lastModifyDate;
        
        TimeStamp[_ID] = newTime;
        
    }
    
    /**
     * @dev get time stamp of the CVE
     * @param _ID bytes32 represents CVE number
     */
    function getTimeStamp(bytes32 _ID) public returns(bytes32, string memory, string memory){
        Time memory t = TimeStamp[_ID];
        return(t.ID, t.publishDate, t.lastModifyDate);
    }
    
}

