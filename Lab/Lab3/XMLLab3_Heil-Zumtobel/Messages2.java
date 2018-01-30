package at.fhv.xmllab;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import at.fhv.xmllab.messages2.jaxb.JAXBInReplyToType;
import at.fhv.xmllab.messages2.jaxb.JAXBMessageListType;
import at.fhv.xmllab.messages2.jaxb.JAXBMessageType;
import at.fhv.xmllab.messages2.jpa.JPAMessage;
import at.fhv.xmllab.messages2.jpa.JPARepliedMessage;

import java.util.*;

public class Messages2 {
    private static final String PERSISTENCE_UNIT_NAME = "xmllab-messages2";
	private static EntityManagerFactory factory;

    public static void load(JAXBMessageListType messagelist) {
	    factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
	    EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();

        // WORK STARTS HERE
		for (JAXBMessageType msg : messagelist.getMessage()) {
			JPAMessage message = new JPAMessage(
					msg.getFrom(),
					msg.getTo(),
					msg.getSubject(),
					msg.getText(),
					null
			);
			em.persist(message);

			for (JAXBInReplyToType reply : msg.getInReplyTo()) {
				em.persist(new JPARepliedMessage(message, reply.getFrom(), reply.getText()));
			}
		}
		JPAMessage message = new JPAMessage(
				"from@ascentlog.com",
				"to@ascentlog.com",
				"AscentLog Information",
				"AscentLog is a very nice project!",
				null
		);
		
		em.persist(message);
		em.persist(new JPARepliedMessage(message, "to@ascentlog.com", "This is the first reply"));
		em.persist(new JPARepliedMessage(message, "from@ascentlog.com", "This is the second reply"));
		// WORK ENDS HERE

		em.getTransaction().commit();		
		em.close();
		factory.close();
    }
}