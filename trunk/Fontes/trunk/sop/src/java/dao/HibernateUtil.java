package dao;

import javax.persistence.PersistenceException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.AnnotationConfiguration;

/**
 *
 * @author Fabricio P. Reis
 */
public class HibernateUtil {

    private static final SessionFactory sessionFactory;
    private static ThreadLocal<Session> sessao = new ThreadLocal<Session>();
    private static ThreadLocal<Transaction> transacao = new ThreadLocal<Transaction>();

    static {
        try {
            // Cria SessionFactory a partir do arquivo de configuracao 'hibernate.cfg.xml'
            sessionFactory = new AnnotationConfiguration().configure("hibernate.cfg.xml").buildSessionFactory();
        } catch (Throwable e) {
            System.err.println("Falha ao criar SessionFactory. Erro: " + e.getMessage());
            throw new ExceptionInInitializerError(e);
        }
    }

    /*
     * Retorna objeto 'sessionFactory'
     */
    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    /*
     * Se nao houver sessao aberta, abri uma e inicia transacao
     * Se nao retorna sessao corrente
     */
    public static Session getSessao() throws Exception {
        try {
            if (sessao.get() == null) {
                iniciaTransacao();
            }
        } catch (Throwable e) {
            System.out.println("Falha ao abrir sessao e iniciar transacao com banco de dados! Erro: " + e.getMessage());
            throw new Exception(e);
        }
        return (Session)sessao.get();
    }

    /*
     * Retorna objeto 'Transaction' (transacao corrente)
     */
    private static Transaction getTransacao() {
        return (Transaction) transacao.get();
    }

    /*
     * Abre a sessao e inicia a transacao
     */
    public static void iniciaTransacao() throws Exception {
        if (sessao.get() != null && sessao.get().isOpen())
            throw new PersistenceException("Falha ao iniciar transacao com banco de dados! Ja existe sessao com o banco e ela esta aberta!");
        // Abre sessao
        sessao.set(getSessionFactory().openSession());
        // Inicia transacao
        transacao.set(getSessao().beginTransaction());

    }

    /*
     * Fecha a sessao e marca os objetos 'sessao' e 'transacao' com null
     */
    public static void fechaSessao() throws Exception {
        try {
            if (getSessao() != null && getSessao().isOpen()) {
                getSessao().close();
            }
        } catch (Exception e) {
            System.out.println("Falha ao fechar sessao com banco de dados! Erro: " + e.getMessage());
            throw new Exception(e);
        }
        finally {
            sessao.set(null);
            transacao.set(null);
        }
    }

    /*
     * Executa commit na transacao e fecha a sessao
     */
    public static void confirma() throws Exception {
        try {
            if (getTransacao() != null) {
                getTransacao().commit();
            }
        } catch (Exception e) {
            System.out.println("Falha ao executar COMMIT no banco de dados! Erro: " + e.getMessage());
            throw new Exception(e);
        }
        finally {
            fechaSessao();
        }
    }

    /*
     * Executa rollback na transacao e fecha a sessao
     */
    public static void aborta() throws Exception {
        try {
            if (getTransacao() != null && getTransacao().isActive()) {
                getTransacao().rollback();
                System.out.println("ROLLBACK executado...");
            }
        } catch (Exception e) {
            System.out.println("Falha ao executar ROLLBACK no banco de dados! Erro: " + e.getMessage());
            throw new Exception(e);
        }
        finally {
            fechaSessao();
        }
    }
}