package service;

import annotations.AtendimentoTratamento;
import annotations.Ficha;
import annotations.FilaAtendimentoTratamento;
import dao.AtendimentoTratamentoDAO;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

/**
 *
 * @author Fabricio P. Reis
 */
public class AtendimentoTratamentoService {

    public AtendimentoTratamentoService() {
    }

    /*
     * Salva registro de atendimento tratamento no banco
     * Se sucesso, retorna o ID do objeto salvo
     * Senao retorna null
     */
    public static Integer salvar(AtendimentoTratamento atendimentoTratamento) {
        Integer id = null;
        AtendimentoTratamentoDAO atendimentoTratamentoDAO = new AtendimentoTratamentoDAO();
        try {
            id = atendimentoTratamentoDAO.salvar(atendimentoTratamento);
        } catch (Exception e) {
            System.out.println("Falha ao salvar registro de atendimento tratamento no banco! Falha ao incluir atendimento tratamento na fila! Exception: " + e.getMessage());
        }
        return id;
    }

    /*
     * Atualiza registro de atendimento tratamento no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(AtendimentoTratamento atendimentoTratamento) {
        AtendimentoTratamentoDAO atendimentoTratamentoDAO = new AtendimentoTratamentoDAO();
        try {
            atendimentoTratamentoDAO.atualizar(atendimentoTratamento);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de atendimento tratamento no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Busca na base registro de atendimentoTratamento com o ID passado como parametro
     * Se encontrar, retorna objeto AtendimentoTratamento
     * Senao, retorna null
     */
    public static AtendimentoTratamento getAtendimentoTratamento(Integer id) {
        AtendimentoTratamentoDAO atendimentoTratamentoDAO = new AtendimentoTratamentoDAO();
        AtendimentoTratamento atendimentoTratamento = null;

        try {
            atendimentoTratamento = atendimentoTratamentoDAO.consultarId(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar AtendimentoTratamento no banco! Metodo AtendimentoTratamentoService.getAtendimentoTratamento(id)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return atendimentoTratamento;
    }

    /*
     * Instancia objeto AtendimentoTratamento e marca Id = 1 (Atendimeto-Tratamento-Sistema)
     */
    public static AtendimentoTratamento getAtendimentoTratamentoSistema() {
        AtendimentoTratamento atendimentoTratamento = new AtendimentoTratamento();
        atendimentoTratamento.setId(1);
        return atendimentoTratamento;
    }

    /*
     * Cria um objeto AtendimentoTratamento associado ah ficha passada como parametro
     * onde o dentista marcado eh o dentista-sistema
     */
    public static AtendimentoTratamento getNovoAtendimentoTratamento(Ficha ficha, FilaAtendimentoTratamento filaAtendimentoTratamento) {
        AtendimentoTratamento atendimentoTratamento = new AtendimentoTratamento();
        atendimentoTratamento.setDataCriacao(new Date());
        atendimentoTratamento.setFicha(ficha);
        atendimentoTratamento.setComissaoDentista(0.0); // Dentista-sistema -> comissao = 0.0
        atendimentoTratamento.setPrioridade(Boolean.FALSE);
        atendimentoTratamento.setDentista(DentistaService.getDentistaSistema());
        atendimentoTratamento.setFilaAtendimentoTratamento(filaAtendimentoTratamento);
        return atendimentoTratamento;
    }

    /*
     * Busca na base os registros de atendimentos de tratamentos que estao na fila de espera
     * Retorna Collection<AtendimentoTratamento>
     */
    public static Collection<AtendimentoTratamento> getAtendimentosFilaAtendimentoTratamento() {
        Collection<AtendimentoTratamento> atendimentoTratamentoCollection = new ArrayList<AtendimentoTratamento>();
        AtendimentoTratamentoDAO atendimentoTratamentoDAO = new AtendimentoTratamentoDAO();
        try {
            atendimentoTratamentoCollection = atendimentoTratamentoDAO.consultarFilaAtendimentoTratamento(FilaAtendimentoTratamentoService.getFilaAtendimentoTratamento());
        } catch (Exception e) {
            System.out.println("Falha ao buscar todos registros de atendimento da fila de tratamento! Metodo AtendimentoTratamentoService.getAtendimentosFilaAtendimentoTratamento. Exception: " + e.getMessage());
            return null;
        }
        return atendimentoTratamentoCollection;
    }

    /*
     * Busca na base os registros de atendimentos de tratamentos que estao em atendimento
     * Retorna ArrayList<AtendimentoTratamento>
     */
    public static Collection<AtendimentoTratamento> getAtendimentosFilaAtendimentoTratamentoEmAtendimento() {
        Collection<AtendimentoTratamento> atendimentoTratamentoCollection = new ArrayList<AtendimentoTratamento>();
        AtendimentoTratamentoDAO atendimentoTratamentoDAO = new AtendimentoTratamentoDAO();
        try {
            atendimentoTratamentoCollection = atendimentoTratamentoDAO.consultarFilaAtendimentoTratamentoEmAtendimento(FilaAtendimentoTratamentoService.getFilaAtendimentoTratamentoEmAtendimento());
        } catch (Exception e) {
            System.out.println("Falha ao buscar todos registros de atendimento tratamento em atendimento! Metodo AtendimentoTratamentoService.getAtendimentosFilaAtendimentoTratamentoEmAtendimento. Exception: " + e.getMessage());
            return null;
        }
        return atendimentoTratamentoCollection;
    }

    /*
     * Busca registro de atendimentoTratamento para a ficha passada como parametro, que nao foi iniciado nem priorizado.
     * Se encontrar, retorna objeto AtendimentoTratamento
     * Senao, retorna null
     */
    public static AtendimentoTratamento getAtendimentoTratamentoNaoIniciadoNaoPriorizado(Ficha ficha) {
        AtendimentoTratamentoDAO atendimentoTratamentoDAO = new AtendimentoTratamentoDAO();
        AtendimentoTratamento atendimentoTratamento = null;

        try {
            atendimentoTratamento = atendimentoTratamentoDAO.consultarAtendimentoTratamentoNaoIniciadoNaoPriorizado(ficha);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar AtendimentoTratamento no banco! Metodo AtendimentoTratamentoService.getAtendimentoTratamentoNaoIniciadoNaoPriorizado(ficha)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return atendimentoTratamento;
    }

    /*
     * Busca registro de atendimentoTratamento para a ficha passada como parametro, que nao foi iniciado.
     * Se encontrar, retorna objeto AtendimentoTratamento
     * Senao, retorna null
     */
    public static AtendimentoTratamento getAtendimentoTratamentoNaoIniciado(Ficha ficha) {
        AtendimentoTratamentoDAO atendimentoTratamentoDAO = new AtendimentoTratamentoDAO();
        AtendimentoTratamento atendimentoTratamento = null;

        try {
            atendimentoTratamento = atendimentoTratamentoDAO.consultarAtendimentoTratamentoNaoIniciado(ficha);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar AtendimentoTratamento no banco! Metodo AtendimentoTratamentoService.getAtendimentoTratamentoNaoIniciado(ficha)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return atendimentoTratamento;
    }
}