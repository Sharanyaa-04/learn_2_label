# ML Knowledge Base (RAG-Optimized)

This repository contains a **Machine Learning knowledge base designed specifically for Retrieval-Augmented Generation (RAG)** systems.

The content is organized so that:
- **One topic = one file**
- **One model = one file**
- **Sections inside a file = retrievable knowledge chunks**

This structure balances **high retrieval precision** with **clean human readability**.

---

## ❓ Is one file per topic good for RAG?

**Yes — this is the recommended approach**, provided the file is **chunked by section headers** during ingestion.

### Design principle used here
> **Files define topic identity**  
> **Sections define retrieval units**

Each `.md` file represents a **single conceptual topic or algorithm**, while each `##` section inside the file is intended to become an individual retrievable chunk.

This avoids:
- Fragmenting concepts across many files
- Metadata duplication
- Retrieval noise from overly large documents

---

## 📁 Repository Structure

```text
ml_knowledge_base/
│
├── foundational_concepts/
│   ├── what_is_machine_learning.md
│   ├── supervised_vs_unsupervised.md
│   ├── features_and_labels.md
│   ├── inputs_vs_outputs.md
│   ├── data_splits.md
│   ├── overfitting_vs_underfitting.md
│   ├── bias_variance_tradeoff.md
│   ├── loss_functions_overview.md
│   ├── evaluation_metrics_overview.md
│   └── regularization_overview.md
│
├── regression/
│   ├── regression_overview.md
│   ├── linear_regression.md
│   ├── ridge_regression.md
│   └── lasso_regression.md
│
├── classification/
│   ├── classification_overview.md
│   ├── logistic_regression.md
│   ├── knn.md
│   ├── svm.md
│   └── naive_bayes.md
│
├── tree_based_models/
│   ├── tree_models_overview.md
│   ├── decision_trees.md
│   └── random_forest.md
│
└── README.md
