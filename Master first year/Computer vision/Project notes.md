## Topic Ideas
has to be lightweight for the few resources we have
- OCR
	1. Efficient OCR
		- https://arxiv.org/html/2304.02737v2
		- https://github.com/dell-research-harvard/efficient_ocr
- 2D to 3D
	1. 2DGuidedLight3D
		- https://arxiv.org/pdf/2212.08334
		- https://github.com/OPradelle/2DGuidedLight3D
	2. Improving 2D Feature Representations by 3D-Aware Fine-Tuning
		- https://arxiv.org/abs/2407.20229
		- https://github.com/ywyue/FiT3D
## Improving 2D Feature Representations by 3D-Aware Fine-Tuning

### **Abstract**

The paper proposes a two-stage approach to enhance 2D visual foundation models (e.g., DINOv2) by integrating 3D awareness. It lifts 2D features into a 3D Gaussian representation, enabling multi-view rendering, and then fine-tunes the original 2D model using these 3D-aware features. This improves performance on downstream tasks like semantic segmentation and depth estimation.

---

### **1. Introduction**

- **Problem**: Current vision models trained on 2D images lack true 3D scene understanding.
    
- **Motivation**: Human vision uses 3D structure cues for better understanding. Models should do the same.
    
- **Proposal**: A two-stage pipeline:
    
    1. Lift 2D features to a 3D Gaussian representation.
        
    2. Use the rendered 3D-aware features to fine-tune 2D models.
        

---

### **2. Related Work**

- **2.1 2D Representation Learning**: Overview of self-supervised learning (e.g., DINO, CLIP), but all trained only on 2D data.
    
- **2.2 Distilled Feature Fusion Fields**: Past works distill 2D features into 3D, e.g., NeRFs. This paper goes further by transferring them back into 2D models.
    
- **2.3 Injecting 3D Priors to 2D**: Most methods fuse 2D into 3D but don’t enhance 2D models with 3D awareness — this paper addresses that gap.
    

---

### **3. Method**

- **3.1 Lifting Features to 3D**:
    - Multi-view 2D features are encoded into 3D Gaussians.
    - ==3D Gaussian Splats== are used for this (a method that models 3D scenes as a collection of transparent, view-dependent blobs (Gaussians))
	    - $\mu$ -> position
	    - Scale, Rotation $s, R$ -> shape and orientation
	    - Opacity $\alpha$
	    - color parameters (SH) -> view dependent RGB info using spherical harmonics
	    - feature vector (f) -> this is the key! Each Gaussian carries a _semantic feature vector_ distilled from 2D features.
        
    - Each Gaussian stores color and a low-dimensional feature vector.
        
    - A CNN decoder up-projects the low-dim feature map after rendering.
    - This two-step projection is crucial due to memory constraints. Storing full 384-dim features per Gaussian would be too heavy.
    - Feature vectors are optimized to fit these 3d gaussians, minimizing a combined loss (`L_total = L_color (RGB image error) + L_feat (feature reconstruction error)`)
        
- **3.2 3D-Aware Fine-Tuning**:
    - Fine-tune the original 2D feature extractor using 3D-rendered features.
    1. **Pre-load** all the 3D Gaussians + CNN decoders for all scenes (to save time).
	2. **For each step**:
	    - Sample an image `Ii` and its camera pose `Pi`.
	    - Use the associated Gaussian `G` to render the high-dim feature map `Fhigh`.
	    - Compare this to the current model’s prediction `ε2D(Ii)` using an L1 loss.
	    - Update the model weights via backprop.
	- Efficient: only 1 epoch required, low memory/computation overhead.
        
- **3.3 Linear Probing for Downstream Tasks**:
	- Once the 2D model is fine-tuned:
	- Keep it frozen.
	- Train a **linear head** (single layer neural network, basically acting to give us the output) on the output features for:
	    - **Semantic segmentation** (per-patch class prediction).
	    - **Depth estimation** (bin classification from patch features + \[CLS\] token).
	- Optionally, **concatenate original features with fine-tuned ones** to retain generalization while gaining 3D awareness.

Linear head analogy -> If the pre-trained model is like a **language**, the linear head is a **simple translator**. If the language is expressive and consistent (good features), the translator can do a good job with minimal effort. If the features are weak, even a smart translator won’t help much.


- **Why use Gaussians?** Fast optimization + real-time rendering + flexibility.
- **Why not train end-to-end?** Memory and time constraints, plus they show you can get strong gains with this two-step approach.
- **Why it works**: Multi-view lifting forces 2D features into geometrically consistent representations, which then teach the 2D model implicit 3D structure.

---

### **4. Experiments**

- **4.1 Datasets**: Use ScanNet++ for training and various indoor/outdoor datasets for evaluation.
- **4.2 Implementation Details**:
    - DINOv2 is fine-tuned for 1 epoch.
    - Feature Gaussians trained using multi-view images.
- **4.3 Within-domain Evaluation**:
    - Significant improvements in segmentation and depth tasks on ScanNet++, NYUv2, and ScanNet.
- **4.4 Out-of-domain Evaluation**:
    - Gains are generalizable to ADE20K, Pascal VOC, and KITTI datasets.
- **4.5 Generalization to Other Vision Models**:
    - Method improves other models like CLIP, MAE, DeiT-III, showing versatility.
- **4.6 Ablation Studies and Analysis**:
    - **Feature dimension**: 64 is a sweet spot between performance and memory.
    - **Assembly strategy**: Feature concatenation works best.
    - **Epochs**: 1 epoch sufficient; more can reduce generalization.
    - **Adapter vs. fine-tuning**: Fine-tuning is simpler and just as effective.

---

### **5. Conclusion**

- The proposed 3D-aware fine-tuning significantly improves the performance of 2D vision models.
- Demonstrates transferability and generalization.
- Future work could expand on more diverse 3D datasets.

---

### **Appendices**

- **A**: ViT variant results — works for ViT-B as well as ViT-S.
    
- **B**: Performance on classification tasks and with more complex heads (e.g., DPT).
    
- **C**: Experiments confirm that gains are due to 3D-aware features, not just increased feature dimensions.
    
- **D**: Visual analysis (PCA, clustering) shows cleaner, more detailed feature maps after fine-tuning.
    

---




Debian 12 doesn't have CUDA toolkit 11.8 so fuck it i'm using colab for my paper. Thanks for nothing, this exam is literally equating to giving birth

Colab also didn't work, now i talked with Lisanti and changed experiment within the paper: no finetuning, but demo inference to study the results.
Useless anyway, i'm gonna work on the presentation now.

