package org.wildfly.swarm.teiid.examples;

import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.wildfly.swarm.Swarm;
import org.wildfly.swarm.jaxrs.JAXRSArchive;
import org.wildfly.swarm.teiid.VDBArchive;

public class Main {
    
    public static void main(String[] args) throws Exception {
        
        Swarm swarm = new Swarm();
        swarm.start();

        VDBArchive vdb = ShrinkWrap.create(VDBArchive.class);
        vdb.vdb(Main.class.getClassLoader().getResourceAsStream("empty-vdb.xml"));
        swarm.deploy(vdb);    
        
        JAXRSArchive testRs = ShrinkWrap.create(JAXRSArchive.class);
        testRs.addResource(TestResource.class);
        swarm.deploy(testRs);

    }


    
}
