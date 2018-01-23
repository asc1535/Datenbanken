package at.fhv.xmltool;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import at.fhv.xmltool.messages2.jaxb.JAXBInReplyToType;
import at.fhv.xmltool.messages2.jaxb.JAXBMessageListType;
import at.fhv.xmltool.messages2.jaxb.JAXBMessageType;
import at.fhv.xmltool.messages2.jpa.JPAMessage;
import at.fhv.xmltool.messages2.jpa.JPARepliedMessage;

public class Messages2 {
    private static final String PERSISTENCE_UNIT_NAME = "xmllab-messages2";
	private static EntityManagerFactory factory;

	//here comes your work
	public static void addSomeMessage(JAXBMessageListType messagelist) {
		JAXBMessageType message1 = new JAXBMessageType();
		message1.setFrom("unicorn@wonderland.at");
		message1.setTo("peter@pan.at");
		message1.setSubject("bloody body");
		message1.setText("hide it fast");

		JAXBInReplyToType repo = new JAXBInReplyToType();
		repo.setFrom("peter@pan.at");
		repo.setText("i did the job");

		message1.getInReplyTo().add(repo);

		messagelist.getMessage().add(message1);
	}
	//end of work


    public static void load(JAXBMessageListType messagelist) {
	    factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
	    EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();

        //here comes your work
		int messageCount = 0;
		int repliedCount = 0;

		for (JAXBMessageType mElem: messagelist.getMessage()) {
			JPAMessage mEntity = new JPAMessage(mElem.getFrom(), mElem.getTo(), mElem.getSubject());
			em.persist(mEntity);
			messageCount++;

			for (JAXBInReplyToType iElem: mElem.getInReplyTo()) {
				JPARepliedMessage rEntity = new JPARepliedMessage(mEntity, iElem.getFrom(), iElem.getText());
				em.persist(rEntity);
				repliedCount++;
			}

		}

		//end of work

		em.getTransaction().commit();		
		em.close();
		factory.close();

		// here comes your work
		System.out.println(messageCount + " messages, " + repliedCount + " repliedMessages successfully imported");
		// end of work
    }
}