package org.openmrs.module.morgueapp.api.dao.hibernate;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.openmrs.Person;
import org.openmrs.module.morgueapp.api.dao.MorgueappDao;

import java.util.List;

public class HibernateMorgueappDao  implements MorgueappDao {
    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private SessionFactory sessionFactory;



    public List<Person> getDeadPeople(){
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
                Person.class);
        criteria.add(Restrictions.eq("dead", true));

        return criteria.list();
    }
}
