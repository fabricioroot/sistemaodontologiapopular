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
@Table(name = "ComprovantePagamentoCartao")
public class ComprovantePagamentoCartao implements Serializable {
    //private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "nomePaciente", nullable = false)
    private String nomePaciente;

    @Column(name = "idPaciente", nullable = false)
    private Integer idPaciente;

    @Column(name = "bandeira", nullable = false)
    private String bandeira;

    @Column(name = "tipo", nullable = false)
    private char tipo;

    @Column(name = "codigoAutorizacao", nullable = false)
    private String codigoAutorizacao;

    @Column(name = "valor", nullable = false)
    private Double valor;

    @Column(name = "parcelas", nullable = false)
    private Short parcelas;

    @Column(name = "dataPagamento", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataPagamento;

    @Column(name = "status", nullable = false)
    private char status;

    @JoinColumn(name = "pagamentoId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.LAZY, targetEntity = Pagamento.class)
    private Pagamento pagamento;

    public ComprovantePagamentoCartao() {
    }

    public ComprovantePagamentoCartao(Integer id, String nomePaciente, Integer idPaciente, String bandeira, char tipo, String codigoAutorizacao, Double valor, Pagamento pagamento, Date dataPagamento) {
        this.id = id;
        this.nomePaciente = nomePaciente;
        this.idPaciente = idPaciente;
        this.bandeira = bandeira;
        this.tipo = tipo;
        this.codigoAutorizacao = codigoAutorizacao;
        this.valor = valor;
        this.pagamento = pagamento;
        this.dataPagamento = dataPagamento;
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

    public String getBandeira() {
        return bandeira;
    }

    public void setBandeira(String bandeira) {
        this.bandeira = bandeira;
    }

    public String getCodigoAutorizacao() {
        return codigoAutorizacao;
    }

    public void setCodigoAutorizacao(String codigoAutorizacao) {
        this.codigoAutorizacao = codigoAutorizacao;
    }

    public Date getDataPagamento() {
        return dataPagamento;
    }

    public void setDataPagamento(Date dataPagamento) {
        this.dataPagamento = dataPagamento;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Pagamento getPagamento() {
        return pagamento;
    }

    public void setPagamento(Pagamento pagamento) {
        this.pagamento = pagamento;
    }

    public Short getParcelas() {
        return parcelas;
    }

    public void setParcelas(Short parcelas) {
        this.parcelas = parcelas;
    }

    public char getStatus() {
        return status;
    }

    public void setStatus(char status) {
        this.status = status;
    }

    public char getTipo() {
        return tipo;
    }

    public void setTipo(char tipo) {
        this.tipo = tipo;
    }

    public Double getValor() {
        return valor;
    }

    public void setValor(Double valor) {
        this.valor = valor;
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
        if (!(object instanceof ComprovantePagamentoCartao)) {
            return false;
        }
        ComprovantePagamentoCartao other = (ComprovantePagamentoCartao) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.ComprovantePagamentoCartao[id=" + id + "]";
    }
}