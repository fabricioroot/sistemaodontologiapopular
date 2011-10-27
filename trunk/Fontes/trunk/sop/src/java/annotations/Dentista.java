package annotations;

import java.util.Set;
import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "Dentista")
@PrimaryKeyJoinColumn(name = "id")
public class Dentista extends Funcionario {
    //private static final long serialVersionUID = 1L;

    @Column(name = "cro", nullable = true, unique = true)
    private String cro;

    @Column(name = "especialidade", nullable = true)
    private String especialidade;

    @Column(name = "comissaoOrcamento", nullable = false)
    private Double comissaoOrcamento;

    @Column(name = "comissaoTratamento", nullable = false)
    private Double comissaoTratamento;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "dentista", fetch = FetchType.LAZY, targetEntity = AtendimentoOrcamento.class)
    private Set<AtendimentoOrcamento> atendimentoOrcamentoSet;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "dentista", fetch = FetchType.LAZY, targetEntity = AtendimentoTratamento.class)
    private Set<AtendimentoTratamento> atendimentoTratamentoSet;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "dentista", fetch = FetchType.LAZY, targetEntity = HistoricoDente.class)
    private Set<HistoricoDente> historicoDenteSet;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "dentista", fetch = FetchType.LAZY, targetEntity = HistoricoBoca.class)
    private Set<HistoricoBoca> historicoBocaSet;

    public Dentista() {
    }

    public Dentista(Integer id) {
        super(id);
    }

    public Dentista(Integer id, String nome, char sexo, Date dataNascimento, Double comissaoOrcamento, Double comissaoTratamento, String nomeDeUsuario, String senha, String fraseEsqueciMinhaSenha, String cargo, char status, String codigoAutenticacao) {
        super(id, nome, sexo, dataNascimento, nomeDeUsuario, senha, fraseEsqueciMinhaSenha, cargo, status, codigoAutenticacao);
        this.comissaoOrcamento = comissaoOrcamento;
        this.comissaoTratamento = comissaoTratamento;
    }

    public String getCro() {
        return cro;
    }

    public void setCro(String cro) {
        this.cro = cro;
    }

    public String getEspecialidade() {
        return especialidade;
    }

    public void setEspecialidade(String especialidade) {
        this.especialidade = especialidade;
    }

    public Double getComissaoOrcamento() {
        return comissaoOrcamento;
    }

    public void setComissaoOrcamento(Double comissaoOrcamento) {
        this.comissaoOrcamento = comissaoOrcamento;
    }

    public Double getComissaoTratamento() {
        return comissaoTratamento;
    }

    public void setComissaoTratamento(Double comissaoTratamento) {
        this.comissaoTratamento = comissaoTratamento;
    }

    public Set<AtendimentoOrcamento> getAtendimentoOrcamentoSet() {
        return atendimentoOrcamentoSet;
    }

    public void setAtendimentoOrcamentoSet(Set<AtendimentoOrcamento> atendimentoOrcamentoSet) {
        this.atendimentoOrcamentoSet = atendimentoOrcamentoSet;
    }

    public Set<AtendimentoTratamento> getAtendimentoTratamentoSet() {
        return atendimentoTratamentoSet;
    }

    public void setAtendimentoTratamentoSet(Set<AtendimentoTratamento> atendimentoTratamentoSet) {
        this.atendimentoTratamentoSet = atendimentoTratamentoSet;
    }

    public Set<HistoricoDente> getHistoricoDenteSet() {
        return historicoDenteSet;
    }

    public void setHistoricoDenteSet(Set<HistoricoDente> historicoDenteSet) {
        this.historicoDenteSet = historicoDenteSet;
    }

    public Set<HistoricoBoca> gethistoricoBocaSet() {
        return historicoBocaSet;
    }

    public void sethistoricoBocaSet(Set<HistoricoBoca> historicoBocaSet) {
        this.historicoBocaSet = historicoBocaSet;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (super.getId() != null ? super.getId().hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Dentista)) {
            return false;
        }
        Dentista other = (Dentista) object;
        if ((super.getId() == null && other.getId() != null) || (super.getId() != null && !super.getId().equals(other.getId()))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.Dentista[pessoaId=" + super.getId() + "]";
    }

}
