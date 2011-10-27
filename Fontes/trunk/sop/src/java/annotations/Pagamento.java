package annotations;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "Pagamento")
public class Pagamento implements Serializable {
   // private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "valor", nullable = false)
    private Double valor;

    @Column(name = "desconto", nullable = false)
    private Double desconto;

    @Column(name = "valorFinal", nullable = false)
    private Double valorFinal;

    @Column(name = "valorEmDinheiro", nullable = false)
    private Double valorEmDinheiro;

    @Column(name = "valorEmCheque", nullable = false)
    private Double valorEmCheque;

    @Column(name = "valorEmCartao", nullable = false)
    private Double valorEmCartao;

    @Column(name = "dataHora", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataHora;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "pagamento", fetch = FetchType.LAZY, targetEntity = ChequeBancario.class)
    private Set<ChequeBancario> chequeBancarioSet;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "pagamento", fetch = FetchType.LAZY, targetEntity = ComprovantePagamentoCartao.class)
    private Set<ComprovantePagamentoCartao> comprovantePagamentoCartaoSet;

    @JoinColumn(name = "formaPagamentoId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.EAGER, targetEntity = FormaPagamento.class)
    private FormaPagamento formaPagamento;

    @JoinColumn(name = "fichaId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.LAZY, targetEntity = Ficha.class)
    private Ficha ficha;

    @JoinColumn(name = "funcionarioId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.LAZY, targetEntity = Funcionario.class)
    private Funcionario funcionario;

    public Pagamento() {
    }

    public Pagamento(Integer id) {
        this.id = id;
    }

    public Pagamento(Integer id, Double valor, Double desconto, Double valorFinal, Date dataHora) {
        this.id = id;
        this.valor = valor;
        this.desconto = desconto;
        this.valorFinal = valorFinal;
        this.dataHora = dataHora;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Double getValor() {
        return valor;
    }

    public void setValor(Double valor) {
        this.valor = valor;
    }

    public Double getDesconto() {
        return desconto;
    }

    public void setDesconto(Double desconto) {
        this.desconto = desconto;
    }

    public Double getValorFinal() {
        return valorFinal;
    }

    public void setValorFinal(Double valorFinal) {
        this.valorFinal = valorFinal;
    }

    public Double getValorEmCartao() {
        return valorEmCartao;
    }

    public void setValorEmCartao(Double valorEmCartao) {
        this.valorEmCartao = valorEmCartao;
    }

    public Double getValorEmCheque() {
        return valorEmCheque;
    }

    public void setValorEmCheque(Double valorEmCheque) {
        this.valorEmCheque = valorEmCheque;
    }

    public Double getValorEmDinheiro() {
        return valorEmDinheiro;
    }

    public void setValorEmDinheiro(Double valorEmDinheiro) {
        this.valorEmDinheiro = valorEmDinheiro;
    }

    public Date getDataHora() {
        return dataHora;
    }

    public void setDataHora(Date dataHora) {
        this.dataHora = dataHora;
    }

    public Set<ComprovantePagamentoCartao> getComprovantePagamentoCartaoSet() {
        return comprovantePagamentoCartaoSet;
    }

    public void setComprovantePagamentoCartaoSet(Set<ComprovantePagamentoCartao> comprovantePagamentoCartaoSet) {
        this.comprovantePagamentoCartaoSet = comprovantePagamentoCartaoSet;
    }

    public Set<ChequeBancario> getChequeBancarioSet() {
        return chequeBancarioSet;
    }

    public void setChequeBancarioSet(Set<ChequeBancario> chequeBancarioSet) {
        this.chequeBancarioSet = chequeBancarioSet;
    }

    public FormaPagamento getFormaPagamento() {
        return formaPagamento;
    }

    public void setFormaPagamento(FormaPagamento formaPagamento) {
        this.formaPagamento = formaPagamento;
    }

    public Ficha getFicha() {
        return ficha;
    }

    public void setFicha(Ficha ficha) {
        this.ficha = ficha;
    }

    public Funcionario getFuncionario() {
        return funcionario;
    }

    public void setFuncionario(Funcionario funcionario) {
        this.funcionario = funcionario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Pagamento)) {
            return false;
        }
        Pagamento other = (Pagamento) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.Pagamento[id=" + id + "]";
    }

}
