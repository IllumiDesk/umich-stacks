from nbgrader.auth import JupyterHubAuthPlugin


c = get_config()

c.Application.log_level = 30

c.Authenticator.plugin_class = JupyterHubAuthPlugin

c.Exchange.path_includes_course = True
c.Exchange.root = "/srv/nbgrader/exchange"

c.ExecutePreprocessor.iopub_timeout=180
c.ExecutePreprocessor.timeout=360
