import 'package:flutter/material.dart';

void main() => runApp(const AcademiaApp());

class AcademiaApp extends StatelessWidget {
  const AcademiaApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Academia',
    theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
    home: const AcademiaPage(),
  );
}

class Registro {
  final String aluno, modalidade, turno;
  const Registro(this.aluno, this.modalidade, this.turno);
}

class AcademiaPage extends StatefulWidget {
  const AcademiaPage({super.key});
  @override
  State<AcademiaPage> createState() => _AcademiaPageState();
}

class _AcademiaPageState extends State<AcademiaPage> {
  final List<Registro> registros = [];

  Future<void> abrirFormulario([int? index]) async {
    final resultado = await Navigator.push<Registro>(context,
      MaterialPageRoute(builder: (_) => FormularioPage(
        registro: index == null ? null : registros[index],
      )));
    if (!mounted || resultado == null) return;
    setState(() {
      if (index == null) {
        registros.add(resultado);
      } else {
        registros[index] = resultado;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Gerenciamento de Academia'),
      backgroundColor: Colors.blue, foregroundColor: Colors.white),
    body: registros.isEmpty
      ? const Center(child: Text('Nenhum aluno cadastrado.'))
      : ListView.builder(
        itemCount: registros.length,
        itemBuilder: (context, index) {
          final registro = registros[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(registro.aluno),
              subtitle: Text('Modalidade: ${registro.modalidade}\nTurno: ${registro.turno}'),
              isThreeLine: true,
              onTap: () => abrirFormulario(index),
              trailing: IconButton(
                tooltip: 'Excluir aluno',
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() => registros.removeAt(index));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registro excluído com sucesso!')));
                },
              ),
            ),
          );
        },
      ),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () => abrirFormulario(),
      icon: const Icon(Icons.add), label: const Text('Cadastrar')),
  );
}

class FormularioPage extends StatefulWidget {
  final Registro? registro;
  const FormularioPage({super.key, this.registro});
  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController aluno, modalidade, turno;
  @override
  void initState() {
    super.initState();
    aluno = TextEditingController(text: widget.registro?.aluno ?? '');
    modalidade = TextEditingController(text: widget.registro?.modalidade ?? '');
    turno = TextEditingController(text: widget.registro?.turno ?? '');
  }
  @override
  void dispose() {
    aluno.dispose(); modalidade.dispose(); turno.dispose();
    super.dispose();
  }
  String? validar(String? valor) => valor == null || valor.trim().isEmpty
    ? 'Este campo é obrigatório' : null;
  Widget campo(String nome, TextEditingController controller, IconData icone) =>
    TextFormField(controller: controller, validator: validar,
      decoration: InputDecoration(labelText: nome, prefixIcon: Icon(icone),
        border: const OutlineInputBorder()));
  void salvar() {
    if (formKey.currentState!.validate()) {
      Navigator.pop(context, Registro(aluno.text.trim(), modalidade.text.trim(), turno.text.trim()));
    }
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.registro == null ? 'Cadastrar aluno' : 'Editar aluno'),
      backgroundColor: Colors.blue, foregroundColor: Colors.white),
    body: SingleChildScrollView(padding: const EdgeInsets.all(20),
      child: Form(key: formKey, child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          campo('Aluno', aluno, Icons.person),
          const SizedBox(height: 16),
          campo('Modalidade', modalidade, Icons.fitness_center),
          const SizedBox(height: 16),
          campo('Turno', turno, Icons.schedule),
          const SizedBox(height: 24),
          ElevatedButton.icon(onPressed: salvar, icon: const Icon(Icons.save), label: const Text('Salvar')),
        ],
      )),
    ),
  );
}
