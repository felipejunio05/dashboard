$(document).ready(() => {
    $("#documentacao").on("click", () => {
        $("#pagina").load("documentacao.html")
    })

    $("#suporte").on('click', () => {
        $("#pagina").load("suporte.html")
    })

    $("#competencia").on("change", e => {
        $.ajax({
            type: "POST",
            url: "app.php",
            data: `competencia=${$(e.target).val()}`,
            dataType: 'json',

            success: data => {
                $("#numeroVendas").html(data.vendas.num)
                $("#totalVendas").html("R$ " + data.vendas.total)
                $("#clientesAtivos").html(data.clientes.ativo)
                $("#clientesInativos").html(data.clientes.inativo)
                $("#totalReclamacoes").html(data.feedbacks.criticas)
                $("#totalElogios").html(data.feedbacks.elogios)
                $("#totalSugestoes").html(data.feedbacks.sugestoes)
                $("#totalDespesas").html("R$ " + data.despesas.total)
            },

            error: erro => { console.log(replay) }
        })
    })
})