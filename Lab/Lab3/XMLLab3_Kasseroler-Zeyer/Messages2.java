package at.fhv.xmltool;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import at.fhv.xmltool.messages2.jaxb.JAXBMessageListType;
import at.fhv.xmltool.messages2.jaxb.JAXBMessageType;
import at.fhv.xmltool.messages2.jaxb.JAXBInReplyToType;
import at.fhv.xmltool.messages2.jpa.JPAMessage;
import at.fhv.xmltool.messages2.jpa.JPARepliedMessage;

public class Messages2 {
    private static final String PERSISTENCE_UNIT_NAME = "xmllab-messages2";
	private static EntityManagerFactory factory;

	public static void addSomeMessage(JAXBMessageListType messageList) {
		JAXBMessageType loveLetter = new JAXBMessageType();
		loveLetter.setFrom("Mellau");
		loveLetter.setTo("Schoppernau");
		loveLetter.setText("Bin i gloffa, d Fuass hon mr weh tau");
		loveLetter.setSubject("loufa");
	
		JAXBInReplyToType replyMessage = new JAXBInReplyToType();
		replyMessage.setFrom("Julia,Julia");
		replyMessage.setText("Er wird scho wissa was r duad");
		loveLetter.getInReplyTo().add(replyMessage);

		messageList.getMessage().add(loveLetter);
	}

    public static void load(JAXBMessageListType messagelist) {
	    factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
	    EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();

        int messageCount = 0;
		int replyMessageCount = 0;
		for (JAXBMessageType pElem: messagelist.getMessage()) {
			JPAMessage pEntity = new JPAMessage(pElem.getFrom(), pElem.getTo(), pElem.getText());
			em.persist(pEntity);
			messageCount++;

			for (JAXBInReplyToType aElem: pElem.getInReplyTo()) {
				//JPAMessage JPAMessage (Father), String fromAdr, String Body
				JPARepliedMessage aEntity = new JPARepliedMessage(					
					pEntity,
					aElem.getFrom(),
					aElem.getText()
					);
				em.persist(aEntity);
				replyMessageCount++;
			}
		}

		em.getTransaction().commit();		
		em.close();
		factory.close();
		System.out.println(messageCount + " messages, " + replyMessageCount + " replyMessage successfully imported");
    }
}