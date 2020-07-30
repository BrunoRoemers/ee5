<?php
class AdminerAutoLogin {
  public function loginForm() {
    $user = getenv('POSTGRES_USER');
    $password = getenv('POSTGRES_PASSWORD');
    echo '<input type="hidden" id="input-driver" name="auth[driver]" value="pgsql">';
    echo '<input type="hidden" name="auth[server]" value="db">';
    echo '<input type="hidden" name="auth[username]" value="'.$user.'">';
    echo '<input type="hidden" name="auth[password]" value="'.$password.'">';
    echo '<input type="hidden" name="auth[db]" value="server_development">';
    $nonce = get_nonce();
    echo <<<SCRIPT
      <script nonce="$nonce">
        window.addEventListener('DOMContentLoaded', (e) => {
          document.getElementById("input-driver").parentElement.submit()
        })
      </script>
    SCRIPT;
    return true; // non null value hides original form
	}
}
?>
