package org.wildfly.swarm.teiid.examples;

import java.io.InputStreamReader;
import java.sql.Connection;

import org.h2.tools.RunScript;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.wildfly.swarm.Swarm;
import org.wildfly.swarm.datasources.DatasourceArchive;
import org.wildfly.swarm.teiid.TeiidFraction;
import org.wildfly.swarm.teiid.VDBArchive;

public class Main {
    
    private static String URL = "jdbc:h2:file:" + System.getProperty("java.io.tmpdir") + "/test";
    
    public static void main(String[] args) throws Exception {
        
        setupH2();
        
        // 1. start container, configure translator
        Swarm swarm = new Swarm();        
        swarm.fraction(new TeiidFraction().translator("h2", t -> t.module("org.jboss.teiid.translator.jdbc")));
        swarm.start();

        // 2. deploy data sources/resource adapter
        swarm.deploy(Swarm.artifact("com.h2database:h2", "h2"));
        DatasourceArchive dsArchive = ShrinkWrap.create(DatasourceArchive.class);
        dsArchive.dataSource("accounts-ds", (ds) -> {
            ds.connectionUrl(URL);
            ds.driverName("h2");
            ds.userName("sa");
            ds.password("sa");
        });
        swarm.deploy(dsArchive);

        // 3. deploy VDB
        VDBArchive vdb = ShrinkWrap.create(VDBArchive.class);
        vdb.vdb(Main.class.getClassLoader().getResourceAsStream("portfolio-vdb.xml"));
        swarm.deploy(vdb);     
    }

    private static void setupH2() throws Exception {

        Connection conn = JDBCUtils.getDriverConnection("org.h2.Driver", URL, "sa", "sa");
        RunScript.execute(conn, new InputStreamReader(Main.class.getClassLoader().getResourceAsStream("customer-schema.sql")));
        JDBCUtils.close(conn);
    }
    
}
