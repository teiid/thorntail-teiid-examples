package org.wildfly.swarm.teiid.examples;

import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.wildfly.swarm.Swarm;
import org.wildfly.swarm.config.Teiid;
import org.wildfly.swarm.config.teiid.Translator;
//import org.wildfly.swarm.datasources.DatasourceArchive;
import org.wildfly.swarm.teiid.TeiidFraction;
import org.wildfly.swarm.teiid.VDBArchive;

public class Main {
    
    // This may get from system property
    static final String teiidFiles = "/home/kylin/src/swarm-teiid-examples/vdb-datafederation/src/main/resources/teiidfiles";

    public static void main(String[] args) throws Exception {
        
        // 1. start container, configure translator
        Swarm swarm = new Swarm();
        
        TeiidFraction f = new TeiidFraction();
        
        f.translator("h2", t -> t.module("org.jboss.teiid.translator.jdbc").slot("api"));
//       
        swarm.fraction(f);
        
        swarm.start();

        // 2. deploy data sources/resource adapter
//        swarm.deploy(Swarm.artifact("com.h2database:h2", "h2"));
//        DatasourceArchive dsArchive = ShrinkWrap.create(DatasourceArchive.class);
//        dsArchive.dataSource("accounts-ds", (ds) -> {
//            ds.connectionUrl("jdbc:h2:mem:accounts;INIT=RUNSCRIPT FROM '" + teiidFiles + "/customer-schema.sql';");
//            ds.driverName("h2");
//            ds.userName("sa");
//            ds.password("sa");
//        });
//        swarm.deploy(dsArchive);

        // 3. deploy VDB
//        VDBArchive vdb = ShrinkWrap.create(VDBArchive.class);
//        vdb.vdb(Main.class.getClassLoader().getResourceAsStream("portfolio-vdb.xml"));
//        swarm.deploy(vdb);     
    }


    
}