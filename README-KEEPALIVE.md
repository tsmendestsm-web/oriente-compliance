# Supabase Keep-Alive — Explore Compliance

Mantém o banco Supabase **sempre ativo**, eliminando a necessidade de acessar
manualmente a cada 7 dias. Roda sozinho via GitHub Actions, **100% gratuito**.

---

## Como funciona

- Um agendamento (cron) dispara a cada **3 dias**.
- Faz uma requisição mínima (PATCH) na tabela `keepalive` do Supabase.
- Essa atividade reseta o contador de inatividade do Supabase.
- Como 3 dias < 7 dias (limite do Supabase), o projeto **nunca pausa**.

Custo: alguns segundos de execução por mês. O GitHub oferece 2.000 minutos/mês
gratuitos — o consumo aqui é praticamente zero.

---

## Configuração (uma vez só — ~5 minutos)

### 1. Crie um repositório no GitHub
- Acesse https://github.com/new
- Nome sugerido: `explore-compliance` (pode ser **privado**)
- Crie o repositório

### 2. Suba os arquivos
Faça upload da pasta `.github/` inteira (contém `workflows/keepalive.yml`)
para o repositório. Pode ser via interface web do GitHub (botão "Add file" →
"Upload files") ou via git.

### 3. Configure os segredos (Secrets)
No repositório GitHub, vá em:
**Settings → Secrets and variables → Actions → New repository secret**

Crie **dois segredos**:

| Nome | Valor |
|------|-------|
| `SUPABASE_URL` | `https://iraddjftufipfugcymly.supabase.co` |
| `SUPABASE_ANON_KEY` | (a chave anon do seu projeto — veja abaixo) |

> A chave anon fica em: Supabase → Settings → API → Project API keys → `anon` `public`

### 4. Ative o workflow
- Vá na aba **Actions** do repositório
- Se aparecer aviso para habilitar workflows, clique em **"I understand my workflows, go ahead and enable them"**
- Clique em **"Supabase Keep-Alive"** na lista à esquerda
- Clique em **"Run workflow"** para testar agora mesmo

Se aparecer ✓ verde, está funcionando. A partir daí, roda sozinho a cada 3 dias.

---

## Verificação

Para confirmar que os pings estão acontecendo, rode no SQL Editor do Supabase:

```sql
SELECT * FROM public.keepalive;
```

O campo `last_ping` mostra a data do último ping, e `ping_count` aumenta a cada execução.

---

## Importante

- Os segredos (Secrets) do GitHub são **criptografados** — ninguém vê o valor depois de salvo, nem você. É o lugar seguro para a chave.
- A chave `anon` é pública por natureza (já fica no front-end do app), então não há risco adicional em usá-la aqui.
- Este sistema **não altera** nenhuma tabela de produção. Usa apenas a tabela isolada `keepalive`.
