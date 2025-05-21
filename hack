from flask import Flask, render_template_string
import threading
import webbrowser

app = Flask(__name__)

HTML_PAGE = '''
<!DOCTYPE html>
<html>
<head>
  <title>Open 20 Tabs</title>
  <script>
    function openTabs() {
      const urls = Array(20).fill("https://www.google.com");

      // Open alle tabbladen direct binnen de klikactie (om blokkering te voorkomen)
      urls.forEach(url => {
        let win = window.open(url, "_blank");
        if (win) {
          win.blur(); // even ontfocussen
        } else {
          alert("⚠️ Je browser heeft het openen van tabbladen geblokkeerd. Sta pop-ups toe!");
        }
      });
    }
  </script>
</head>
<body>
  <h1>Klik op de knop om 20 Google-tabbladen te openen</h1>
  <button onclick="openTabs()">🧨 Open 20 Tabs</button>
  <p><strong>⚠️ Als er maar 1 of 2 openen: klik op het pop-up icoon rechtsboven en kies 'Toestaan'.</strong></p>
</body>
</html>
'''

@app.route("/")
def index():
    return render_template_string(HTML_PAGE)

def open_browser():
    webbrowser.open("http://127.0.0.1:5000")

if __name__ == "__main__":
    threading.Timer(1.0, open_browser).start()
    app.run()
