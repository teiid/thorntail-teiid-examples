package org.wildfly.swarm.teiid.examples;


import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.wildfly.swarm.Swarm;
import org.wildfly.swarm.teiid.TeiidFraction;
import org.wildfly.swarm.teiid.VDBArchive;

public class Main {
    
    public static void main(String[] args) throws Exception {
        
        Swarm swarm = new Swarm(); 
        swarm.fraction(new TeiidFraction().translator("loopback", t -> t.module("org.jboss.teiid.translator.loopback")));
        swarm.start();

        VDBArchive vdb = ShrinkWrap.create(VDBArchive.class);
        vdb.vdb(Main.class.getClassLoader().getResourceAsStream("loopback-vdb.xml"));
        swarm.deploy(vdb);     
    }


    
}
