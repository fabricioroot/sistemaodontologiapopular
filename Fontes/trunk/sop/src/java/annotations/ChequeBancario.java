package annotations;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "ChequeBancario")
public class ChequeBancario implements Serializable {
    //private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "nomePaciente", nullable = false)
    private String nomePaciente;

    @Column(name = "idPaciente", nullable = false)
    private Integer idPaciente;

    @Column(name = "nomeTitular", nullable = false)
    private String nomeTitular;

    @Column(name = "cpfTitular", nullable = false)
    private String cpfTitular;

    @Column(name = "rgTitular", nullable = true)
    private String rgTitular;

    @Column(name = "banco", nullable = false)
    private String banco;

    @Column(name = "numero", nullable = false)
    private String numero;

    @Column(name = "valor", nullable = false)
    private Double valor;

    @Column(name = "dataParaDepositar", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataParaDepositar;

    @JoinColumn(name = "statusChequeBancarioId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.EAGER, targetEntity = StatusChequeBancario.class)
    private StatusChequeBancario status;

    @JoinColumn(name = "pagamentoId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = true, fetch = FetchType.LAZY, targetEntity = Pagamento.class)
    private Pagamento pagamento;

    public ChequeBancario() {
    }

    public ChequeBancario(Integer id) {
        this.id = id;
    }

    public ChequeBancario(Integer id, String nomePaciente, Integer idPaciente, String nomeTitular, String cpfTitular, String rgTitular, String banco, String numero, Double valor, Date dataParaDepositar) {
        this.id = id;
        this.nomePaciente = nomePaciente;
        this.idPaciente = idPaciente;
        this.nomeTitular = nomeTitular;
        this.cpfTitular = cpfTitular;
        this.rgTitular = rgTitular;
        this.banco = banco;
        this.numero = numero;
        this.valor = valor;
        this.dataParaDepositar = dataParaDepositar;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNomeTitular() {
        return nomeTitular;
    }

    public void setNomeTitular(String nomeTitular) {
        this.nomeTitular = nomeTitular;
    }

    public String getNomePaciente() {
        return nomePaciente;
    }

    public void setNomePaciente(String nomePaciente) {
        this.nomePaciente = nomePaciente;
    }

    public Integer getIdPaciente() {
        return idPaciente;
    }

    public void setIdPaciente(Integer idPaciente) {
        this.idPaciente = idPaciente;
    }

    public String getCpfTitular() {
        return cpfTitular;
    }

    public void setCpfTitular(String cpfTitular) {
        this.cpfTitular = cpfTitular;
    }

    public String getRgTitular() {
        return rgTitular;
    }

    public void setRgTitular(String rgTitular) {
        this.rgTitular = rgTitular;
    }

    public String getBanco() {
        return banco;
    }

    public void setBanco(String banco) {
        this.banco = banco;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public Double getValor() {
        return valor;
    }

    public void setValor(Double valor) {
        this.valor = valor;
    }

    public Date getDataParaDepositar() {
        return dataParaDepositar;
    }

    public void setDataParaDepositar(Date dataParaDepositar) {
        this.dataParaDepositar = dataParaDepositar;
    }

    public Pagamento getPagamento() {
        return pagamento;
    }

    public void setPagamento(Pagamento pagamento) {
        this.pagamento = pagamento;
    }

    public StatusChequeBancario getStatus() {
        return status;
    }

    public void setStatus(StatusChequeBancario statusChequeBancario) {
        this.status = statusChequeBancario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ChequeBancario)) {
            return false;
        }
        ChequeBancario other = (ChequeBancario) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.ChequeBancario[id=" + id + "]";
    }
}