<%
    String anoParam = request.getParameter("ano");
    String mesParam = request.getParameter("mes");
    boolean dadosValidos = true;

    if (anoParam != null && mesParam != null) {
        try {
            int ano = Integer.parseInt(anoParam);
            int mes = Integer.parseInt(mesParam) - 1;

            java.util.Calendar calendario = java.util.Calendar.getInstance();
            calendario.clear();
            calendario.setLenient(false);
            calendario.set(ano, mes, 1);

            int diasNoMes = calendario.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
            int primeiroDiaDaSemana = calendario.get(java.util.Calendar.DAY_OF_WEEK);

            String nomeMes = new java.text.SimpleDateFormat("MMMM").format(calendario.getTime());

            StringBuilder calendarioHtml = new StringBuilder();
            calendarioHtml.append("<h2>").append(nomeMes).append(" de ").append(ano).append("</h2>");
            calendarioHtml.append("<table>");
            calendarioHtml.append("<tr><th>Dom</th><th>Seg</th><th>Ter</th><th>Qua</th><th>Qui</th><th>Sex</th><th>Sáb</th></tr>");

            int contador = 1;
            calendarioHtml.append("<tr>");

            for (int i = 1; i < primeiroDiaDaSemana; i++) {
                calendarioHtml.append("<td></td>");
                contador++;
            }

            for (int i = 1; i <= diasNoMes; i++) {
                calendario.setTime(new java.util.Date(ano - 1900, mes, i));
                String estilo = (i == calendario.get(java.util.Calendar.DAY_OF_MONTH)) ? "color: red;" : "";
                calendarioHtml.append("<td style=\"" + estilo + "\">").append(i).append("</td>");
                contador++;
                if (contador % 7 == 1) {
                    calendarioHtml.append("</tr><tr>");
                }
            }

            while (contador % 7 != 1) {
                calendarioHtml.append("<td></td>");
                contador++;
            }

            calendarioHtml.append("</tr>");
            calendarioHtml.append("</table>");

            out.println(calendarioHtml.toString());
        } catch (NumberFormatException e) {
            out.println("<p>Por favor, forneça um número válido para o ano e mês.</p>");
            dadosValidos = false;
        } catch (IllegalArgumentException e) {
            out.println("<p>A data fornecida é inválida. Por favor, forneça uma data válida.</p>");
            dadosValidos = false;
        }
    } else {
        dadosValidos = false;
    }

    if (!dadosValidos) {
%>
    <h2>Por favor, forneça os parâmetros corretos:</h2>
    <form action="" method="get">
        <label for="ano">Ano:</label>
        <input type="text" id="ano" name="ano" required><br><br>
        
        <label for="mes">Mês:</label>
        <input type="text" id="mes" name="mes" required><br><br>
        
        <input type="submit" value="Mostrar Calendário">
    </form>
<%
    }
%>
