package annotations;

import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;


/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "Paciente")
@PrimaryKeyJoinColumn(name = "id")
public class Paciente extends Pessoa {
    //private static final long serialVersionUID = 1L;

    @Column(name = "indicacao", nullable = false)
    private String indicacao;

    @Column(name = "impedimento", nullable = true)
    private String impedimento;

    @Column(name = "status", nullable = false)
    private char status;

    @Column(name = "filaOrcamento", nullable = false)
    private Boolean filaOrcamento;

    @Column(name = "filaTratamento", nullable = false)
    private Boolean filaTratamento;

    @OneToOne(optional = true, cascade = CascadeType.ALL, mappedBy = "paciente", fetch = FetchType.LAZY, targetEntity = Ficha.class)
    private Ficha ficha;

    @OneToOne(optional = true, cascade = CascadeType.ALL, mappedBy = "paciente", fetch = FetchType.EAGER, targetEntity = Boca.class)
    private Boca boca;

    public Paciente() {
    }

    public Paciente(Integer id) {
        super(id);
    }

    public Paciente(Integer id, String nome, char sexo, Date dataNascimento, String indicacao, char status) {
        super(id, nome, sexo, dataNascimento);
        this.indicacao = indicacao;
        this.status = status;
    }

    public String getIndicacao() {
        return indicacao;
    }

    public void setIndicacao(String indicacao) {
        this.indicacao = indicacao;
    }

    public Boolean isFilaOrcamento() {
        return filaOrcamento;
    }

    public void setFilaOrcamento(Boolean filaOrcamento) {
        this.filaOrcamento = filaOrcamento;
    }

    public Boolean isFilaTratamento() {
        return filaTratamento;
    }

    public void setFilaTratamento(Boolean filaTratamento) {
        this.filaTratamento = filaTratamento;
    }

    public String getImpedimento() {
        return impedimento;
    }

    public void setImpedimento(String impedimento) {
        this.impedimento = impedimento;
    }

    public char getStatus() {
        return status;
    }

    public void setStatus(char status) {
        this.status = status;
    }

    public Ficha getFicha() {
        return ficha;
    }

    public void setFicha(Ficha ficha) {
        this.ficha = ficha;
    }

    public Boca getBoca() {
        return boca;
    }

    public void setBoca(Boca boca) {
        this.boca = boca;
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
        if (!(object instanceof Paciente)) {
            return false;
        }
        Paciente other = (Paciente) object;
        if ((super.getId() == null && other.getId() != null) || (super.getId() != null && !super.getId().equals(other.getId()))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.Paciente[pessoaId=" + super.getId() + "]";
    }

}
