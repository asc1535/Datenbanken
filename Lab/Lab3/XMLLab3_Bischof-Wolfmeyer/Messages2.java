package at.fhv.xmltool;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import at.fhv.xmltool.messages2.jaxb.JAXBMessageListType;

public class Messages2 {
    private static final String PERSISTENCE_UNIT_NAME = "xmllab-messages2";
	private static EntityManagerFactory factory;
	
	public static void addSomeMessage(JAXBMessageListType messageList) {
		JAXBMessageType someMessage = new JAXBMessageType();
		someMessage.setFrom("New York City");
		someMessage.setTo("Washington D.C.");
		someMessage.setText("Make 'Murica Great Again.");
		someMessage.setSubject("Donald J. Trump");
	
		JAXBInReplyToType replyMessage = new JAXBInReplyToType();
		replyMessage.setFrom("Hillary Clinton");
		replyMessage.setText("Yeah, whatever");
		someMessage.getInReplyTo().add(replyMessage);

		messageList.getMessage().add(loveLetter);
	}

    public static void load(JAXBMessageListType messagelist) {
	    factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
	    EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();

        //here comes your work
		int messageCount = 0;
		int replyMessageCount = 0;
		
		for (JAXBMessageType pElem : messagelist.getMessage()) {
			JPARepliedMessage aEntity = new JPARepliedMessage(
					pEntity,
					aElem.getFrom(),
					aElem.getText()
			);
			em.persist(aEntity);
			replyMessageCount++;
		}
		

		em.getTransaction().commit();		
		em.close();
		factory.close();
    }
}