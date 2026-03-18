# Create README.md file with the provided content

content = """<h1 align="center">Terraform Type Constraints</h1>

<p align="center">
Simple and beginner-friendly guide to understand Terraform variable types.
</p>

<hr>

<h2>📌 What are Type Constraints?</h2>

<p>
Type constraints define <b>what kind of value</b> a variable can accept in Terraform.
They help avoid errors and make your code safe and clear.
</p>

<p><b>Simple meaning:</b> Type constraint = rule for variable value</p>

<hr>

<h2>🎯 Why Use Type Constraints?</h2>

<ul>
  <li>Prevent wrong inputs</li>
  <li>Improve code readability</li>
  <li>Reduce errors</li>
  <li>Make code professional</li>
</ul>

<hr>

<h2>🧩 Types of Type Constraints</h2>

<h3>1. String</h3>
<p>Used for text values.</p>

<pre><code>variable "name" {
  type = string
}</code></pre>

<p><b>Example:</b> "Rudra"</p>

<hr>

<h3>2. Number</h3>
<p>Used for numeric values.</p>

<pre><code>variable "port" {
  type = number
}</code></pre>

<p><b>Example:</b> 8080</p>

<hr>

<h3>3. Boolean</h3>
<p>Used for true/false values.</p>

<pre><code>variable "monitoring" {
  type = bool
}</code></pre>

<p><b>Example:</b> true</p>

<hr>

<h3>4. List</h3>
<p>Used for multiple values (ordered).</p>

<pre><code>variable "instance_type" {
  type = list(string)
}</code></pre>

<p><b>Example:</b></p>

<pre><code>["t2.micro", "t2.medium"]</code></pre>

<p><b>Access:</b> var.instance_type[0]</p>

<hr>

<h3>5. Set</h3>
<p>Used for unique values (no duplicates).</p>

<pre><code>variable "regions" {
  type = set(string)
}</code></pre>

<p><b>Example:</b></p>

<pre><code>["ap-south-1", "us-east-1"]</code></pre>

<p><b>Note:</b> Order is not guaranteed.</p>

<hr>

<h3>6. Map</h3>
<p>Used for key-value pairs.</p>

<pre><code>variable "instance_map" {
  type = map(string)
}</code></pre>

<p><b>Example:</b></p>

<pre><code>{
  dev  = "t2.micro"
  prod = "t2.medium"
}</code></pre>

<p><b>Access:</b> var.instance_map["dev"]</p>

<hr>

<h2>📊 Summary</h2>

<table border="1" cellpadding="8">
  <tr>
    <th>Type</th>
    <th>Use</th>
    <th>Example</th>
  </tr>
  <tr>
    <td>string</td>
    <td>Text</td>
    <td>"hello"</td>
  </tr>
  <tr>
    <td>number</td>
    <td>Number</td>
    <td>100</td>
  </tr>
  <tr>
    <td>bool</td>
    <td>true/false</td>
    <td>true</td>
  </tr>
  <tr>
    <td>list</td>
    <td>Multiple ordered values</td>
    <td>["a","b"]</td>
  </tr>
  <tr>
    <td>set</td>
    <td>Unique values</td>
    <td>["a","b"]</td>
  </tr>
  <tr>
    <td>map</td>
    <td>Key-value pairs</td>
    <td>{key="value"}</td>
  </tr>
</table>

<hr>

<h2>🚀 Final Note</h2>

<p>
Using type constraints is a <b>best practice</b> in Terraform.
It helps you write clean and error-free infrastructure code.
</p>

<p><b>Remember:</b></p>
<ul>
  <li>string → text</li>
  <li>number → number</li>
  <li>bool → true/false</li>
  <li>list → ordered values</li>
  <li>set → unique values</li>
  <li>map → key-value</li>
</ul>

<hr>

<p align="center">✨ Happy Learning Terraform ✨</p>
"""

file_path = "/mnt/data/README.md"
with open(file_path, "w") as f:
    f.write(content)

file_path