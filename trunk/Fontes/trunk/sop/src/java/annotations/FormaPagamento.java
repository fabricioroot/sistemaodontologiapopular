package annotations;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import org.directwebremoting.annotations.DataTransferObject;
import org.directwebremoting.annotations.Param;
import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import service.DwrUtil;
import service.FormaPagamentoService;

/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "FormaPagamento")
@RemoteProxy
@DataTransferObject(params = @Param(name = "exclude", value = "pagamentoSet"))
public class FormaPagamento implements Serializable {
    //private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Short id;

    @Column(name = "nome", nullable = false, unique = true)
    private String nome;

    @Lob
    @Column(name = "descricao", nullable = false)
    private String descricao;

    @Column(name = "status", nullable = false)
    private char status;

    @Column(name = "tipo", nullable = false)
    private char tipo;

    @Column(name = "valorMinimoAPrazo", nullable = true)
    private Double valorMinimoAPrazo;

    @Column(name = "desconto", nullable = true)
    private Double desconto;

    @Column(name = "pisoParaDesconto", nullable = true)
    private Double pisoParaDesconto;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "formaPagamento", fetch = FetchType.LAZY, targetEntity = Pagamento.class)
    private Set<Pagamento> pagamentoSet;

    @Transient
    private Collection<FormaPagamento> formasDePagamento = new ArrayList<FormaPagamento>();

    public FormaPagamento() {
    }

    public FormaPagamento(Short id) {
        this.id = id;
    }

    public FormaPagamento(Short id, String nome, String descricao, char status, char tipo, Double valorMinimoAPrazo, Double desconto, Double pisoParaDesconto) {
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
        this.status = status;
        this.tipo = tipo;
        this.valorMinimoAPrazo = valorMinimoAPrazo;
        this.desconto = desconto;
        this.pisoParaDesconto = pisoParaDesconto;
    }

    public Short getId() {
        return id;
    }

    public void setId(Short id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
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

    public Double getValorMinimoAPrazo() {
        return valorMinimoAPrazo;
    }

    public void setValorMinimoAPrazo(Double valorMinimoAPrazo) {
        this.valorMinimoAPrazo = valorMinimoAPrazo;
    }

    public Double getDesconto() {
        return desconto;
    }

    public void setDesconto(Double desconto) {
        this.desconto = desconto;
    }

    public Double getPisoParaDesconto() {
        return pisoParaDesconto;
    }

    public void setPisoParaDesconto(Double pisoParaDesconto) {
        this.pisoParaDesconto = pisoParaDesconto;
    }

    public Set<Pagamento> getPagamentoSet() {
        return pagamentoSet;
    }

    public void setPagamentoSet(Set<Pagamento> pagamentoSet) {
        this.pagamentoSet = pagamentoSet;
    }

    @RemoteMethod
    public void carregarFormasDePagamento() {
        // Remove as opcoes do combo formas de pagamento
        DwrUtil.getUtil().removeAllOptions("formaPagamentoId");

        FormaPagamento formaPagamento = new FormaPagamento();
        formaPagamento.setNome("Selecione");
        this.formasDePagamento.add(formaPagamento);

        // Busca no banco as formas de pagamento ativas
        this.formasDePagamento.addAll(FormaPagamentoService.getFormasDePagamentoAtivas());

        //Adicionando a lista de formas de pagamento a combo apropriada
        DwrUtil.getUtil().addOptions("formaPagamentoId", this.formasDePagamento, "id", "nome");
    }

    @RemoteMethod
    public void marcarValores(String formaPagamentoId) {
        // Marreta!
        if (formaPagamentoId == null || formaPagamentoId.equals("null")) {
            formaPagamentoId = "";
        }
        if (!formaPagamentoId.isEmpty()) {
            // Busca no banco a forma de pagamento
            FormaPagamento formaPagamento = FormaPagamentoService.getFormaPagamento(Short.parseShort(formaPagamentoId));
            DecimalFormat decimalFormat = new DecimalFormat("0.00");

            // Mostrar / Sumir <div> apropriado e marcar campos
            // Tipo 'A vista'
            if (formaPagamento.getTipo() == 'A') {
                DwrUtil.getUtil().setStyle("pagamentoAPrazo", "display", "none");
                DwrUtil.getUtil().setStyle("pagamentoAVista", "display", "block");
                DwrUtil.getUtil().setValue("totalAVistaEmDinheiro", Double.parseDouble("0.0"));
                DwrUtil.getUtil().setValue("desconto", formaPagamento.getDesconto());
                DwrUtil.getUtil().setValue("descontoVisual", formaPagamento.getDesconto());
                DwrUtil.getUtil().setValue("pisoParaDesconto", decimalFormat.format(formaPagamento.getPisoParaDesconto()));
                // Chamada de funcao javaScript que calcula o total
                DwrUtil.getUtil().addFunctionCall("calcularTotalAVista");
                // Zera campo de pagamento 'A Prazo'
                DwrUtil.getUtil().setValue("totalAPrazoEmDinheiro", Double.parseDouble("0.0"));
                DwrUtil.getUtil().setValue("tipoPagamento", "A");
            } else
            // Tipo 'A Prazo'
            if (formaPagamento.getTipo() == 'P') {
                DwrUtil.getUtil().setStyle("pagamentoAPrazo", "display", "block");
                DwrUtil.getUtil().setStyle("pagamentoAVista", "display", "none");
                DwrUtil.getUtil().setValue("totalAPrazoEmDinheiro", Double.parseDouble("0.0"));
                DwrUtil.getUtil().setValue("valorMinimoAPrazo", decimalFormat.format(formaPagamento.getValorMinimoAPrazo()));
                // Chamada de funcao javaScript que calcula o total
                DwrUtil.getUtil().addFunctionCall("calcularTotalAPrazo");
                // Zera campo de pagamento 'A Vista'
                DwrUtil.getUtil().setValue("totalAVistaEmDinheiro", Double.parseDouble("0.0"));
                DwrUtil.getUtil().setValue("tipoPagamento", "P");
            }
        }
        else {
            // Esconde os <div>s e limpa os campos
            DwrUtil.getUtil().setStyle("pagamentoAPrazo", "display", "none");
            DwrUtil.getUtil().setStyle("pagamentoAVista", "display", "none");
            DwrUtil.getUtil().setValue("tipoPagamento", "");
            // Tipo 'A vista'
            DwrUtil.getUtil().setValue("totalAVistaEmDinheiro", "");
            DwrUtil.getUtil().setValue("desconto", "");
            DwrUtil.getUtil().setValue("descontoVisual", "");
            DwrUtil.getUtil().setValue("pisoParaDesconto", "");
            DwrUtil.getUtil().setValue("subtotalAVista", "");
            DwrUtil.getUtil().setValue("totalAVistaComDesconto", "");
            // Tipo 'A Prazo'
            DwrUtil.getUtil().setValue("valorMinimoAPrazo", "");
            DwrUtil.getUtil().setValue("totalAPrazoEmDinheiro", "");
            DwrUtil.getUtil().setValue("subtotalAPrazo", "");
            DwrUtil.getUtil().setValue("totalAPrazo", "");
        }
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
        if (!(object instanceof FormaPagamento)) {
            return false;
        }
        FormaPagamento other = (FormaPagamento) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.FormaPagamento[id=" + id + "]";
    }
}