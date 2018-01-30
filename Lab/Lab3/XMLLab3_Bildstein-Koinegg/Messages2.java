package at.fhv.xmltool;

import java.util.Set;
import java.util.HashSet;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import antlr.debug.MessageAdapter;
import at.fhv.xmltool.addressbook.jaxb.JAXBAddressType;
import at.fhv.xmltool.addressbook.jaxb.JAXBAddressbookType;
import at.fhv.xmltool.addressbook.jaxb.JAXBPersonType;
import at.fhv.xmltool.messages2.jaxb.JAXBInReplyToType;
import at.fhv.xmltool.messages2.jaxb.JAXBMessageListType;
import at.fhv.xmltool.messages2.jaxb.JAXBMessageType;
import at.fhv.xmltool.messages2.jpa.JPAMessage;
import at.fhv.xmltool.messages2.jpa.*;

public class Messages2 {
    private static final String PERSISTENCE_UNIT_NAME = "xmllab-messages2";
	private static EntityManagerFactory factory;

	public static void addSomeMessages(JAXBMessageListType messageList) {
		JAXBMessageType messageOne = new JAXBMessageType(); 
		messageOne.setFrom("Raphael");
		messageOne.setSubject("Homework");
		messageOne.setText("I need help");
		messageOne.setTo("Lukas");
		
		JAXBInReplyToType replyOne = new JAXBInReplyToType(); 
		replyOne.setFrom("Lukas");
		replyOne.setText("What's the problem?");
		
		JAXBInReplyToType replyTwo = new JAXBInReplyToType();
		replyTwo.setFrom("Raphael");
		replyTwo.setText("I deleted the internet!");
		
		messageOne.getInReplyTo().add(replyOne);
		messageOne.getInReplyTo().add(replyTwo);
		
		messageList.getMessage().add(messageOne); 
	}
	
    public static void load(JAXBMessageListType messagelist) {
	    factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
	    EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();

		//here comes your work
		
		for(JAXBMessageType mElem : messagelist.getMessage()){
			JPAMessage mEntity = new JPAMessage(mElem.getFrom(), mElem.getTo(), mElem.getSubject());
			em.persist(mEntity);

			Set<JPARepliedMessage> replyMessages = new HashSet<>(); 

			for (JAXBInReplyToType rElem: mElem.getInReplyTo()) {
				JPARepliedMessage rEntity = new JPARepliedMessage(mEntity, rElem.getFrom(), rElem.getText()); 
				em.persist(rEntity);
				replyMessages.add(rEntity); 
			}

			mEntity.setJPARepliedMessages(replyMessages);
			mEntity.setBody(mElem.getText()); 
		}

		em.getTransaction().commit();		
		em.close();
		factory.close();
    }
}