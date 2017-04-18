package org.wildfly.swarm.teiid.examples;

import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;

import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;

import org.h2.tools.RunScript;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.wildfly.swarm.Swarm;
import org.wildfly.swarm.datasources.DatasourcesFraction;
import org.wildfly.swarm.resource.adapters.ResourceAdapterFraction;
import org.wildfly.swarm.teiid.TeiidFraction;
import org.wildfly.swarm.teiid.VDBArchive;

public class Main {
    
    private static String URL = "jdbc:h2:file:" + System.getProperty("java.io.tmpdir") + "/test";
    private static String marketdataDir;
    
    
    public static void main(String[] args) throws Exception {
        
        setupSampleSources();
        
        Swarm swarm = new Swarm();        
        swarm.fraction(new TeiidFraction()
                 .translator("h2", t -> t.module("org.jboss.teiid.translator.jdbc"))
                 .translator("file", t -> t.module("org.jboss.teiid.translator.file")))
             .fraction(new DatasourcesFraction()
                 .dataSource("accounts-ds", ds -> {
                     ds.driverName("h2"); // the 'h2' are auto-detected, and registered dynamic 
                     ds.connectionUrl(URL);
                     ds.userName("sa");
                     ds.password("sa");
                 }))
             .fraction(new ResourceAdapterFraction()
                 .resourceAdapter("fileQS", rac -> rac.module("org.jboss.teiid.resource-adapter.file")
                     .connectionDefinitions("fileQS", cdc -> cdc.className("org.teiid.resource.adapter.file.FileManagedConnectionFactory")
                         .jndiName("java:/marketdata-file")
                         .configProperties("ParentDirectory", cpc -> cpc.value(marketdataDir))
                         .configProperties("AllowParentPaths", cpc -> cpc.value("true")))));
        swarm.start();

        VDBArchive vdb = ShrinkWrap.create(VDBArchive.class);
        vdb.vdb(Main.class.getClassLoader().getResourceAsStream("portfolio-vdb.xml"));
        swarm.deploy(vdb);   
    }

    private static void setupSampleSources() throws Exception {

        Connection conn = JDBCUtils.getDriverConnection("org.h2.Driver", URL, "sa", "sa");
        RunScript.execute(conn, new InputStreamReader(Main.class.getClassLoader().getResourceAsStream("teiidfiles/customer-schema.sql")));
        JDBCUtils.close(conn);
        
        Path target = Paths.get(System.getProperty("java.io.tmpdir"), "teiidfiles");
        marketdataDir = target.toString();
        if(!Files.exists(target)){
            Files.createDirectories(target);
        }
        target.toFile().deleteOnExit();
        Files.copy(Main.class.getClassLoader().getResourceAsStream("teiidfiles/data/marketdata-price.txt"), target.resolve("marketdata-price.txt"), REPLACE_EXISTING);
        Files.copy(Main.class.getClassLoader().getResourceAsStream("teiidfiles/data/marketdata-price1.txt"), target.resolve("marketdata-price1.txt"), REPLACE_EXISTING);
  
    }
    
}
