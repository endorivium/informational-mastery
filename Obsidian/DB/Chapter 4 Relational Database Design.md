# Functional Dependency

> -> specifies the relationship between two sets of attributes where one attribute determines the value of another attribute.
> X determines Y: <mark style="background: #ABF7F7A6;">X (Determinant) -> Y (Dependent)</mark>

![[Pasted image 20251104132710.png]]

A determines B where for all
- t$_i$ and t$_j$  are element of r (meaning they are present in the table) where i does not equal j
- A and B are proper subsets of the relation R
- and A is the same for two different tuples
- whereas the values for B are the same in all instances of the database
i.e. one A can have multiple B assigned but not the other way around (aka unique key - value)

**<span style="color:rgb(146, 208, 80)">Superkey</span>**
> When there is a relationship with attributes, then a subset of attributes is called a <span style="color:rgb(0, 176, 240)">Superkey</span> if 
>			 A -> R (A determines the whole relation). 
> The superkey can consist of more than one attribute as long it determines the whole relationship.

**<span style="color:rgb(146, 208, 80)">Key/ Candidate Key</span>**
> A<span style="color:rgb(255, 192, 0)"> minimal subset </span>of a superkey that still fulfills its property is called a <span style="color:rgb(0, 176, 240)">Key</span> or <span style="color:rgb(0, 176, 240)">Candidate Key</span>.
> ![[Pasted image 20251104135027.png]]
> <span style="color:rgb(255, 192, 0)">K</span> is a key of R if K determines R and there is no subset of K that determines R. An attribbute that is a part of a key is called a <span style="color:rgb(0, 176, 240)">prime attribute</span>.
> A <span style="color:rgb(0, 176, 240)">primary key</span> is one of the candidate keys that is selected as such, i.e. superkeys > candidate keys > primary key

<span style="color:rgb(146, 208, 80)">Foreign Key</span>
> A subset of the relation R fulfills the <span style="color:rgb(0, 176, 240)">foreign key constraint</span> of a subset of S when
> ![[Pasted image 20251104135406.png]]
> If that property is fulfilled in all instances of the database, the subset is called a <span style="color:rgb(0, 176, 240)">foreign key</span>.

## Properties of Functional Dependencies

<span style="color:rgb(146, 208, 80)">Triviality</span>
> An attribute <span style="color:rgb(255, 192, 0)">always determines itself</span>: A -> A

<span style="color:rgb(146, 208, 80)">Reflexivity</span>
> If <span style="color:rgb(255, 192, 0)">Y is a subset of X</span> which is a subset of R, then<span style="color:rgb(255, 192, 0)"> X determines Y</span>
>  ![[Pasted image 20251104140456.png]]

<span style="color:rgb(146, 208, 80)">Augmentation</span>
> If an attribute determines another, then <span style="color:rgb(255, 192, 0)">adding another attribute set does not change</span> this as long as the <span style="color:rgb(255, 192, 0)">augmentation is equal on both sides</span> (similar to equations).
> ![[Pasted image 20251104140717.png]]

<span style="color:rgb(146, 208, 80)">Decomposition</span>
> Functional dependencies <span style="color:rgb(255, 192, 0)">can be decomposed into its individual parts</span> as long as the Determinant is not split.
> ![[Pasted image 20251104140921.png]]

<span style="color:rgb(146, 208, 80)">Union</span>
> Functional dependencies <span style="color:rgb(255, 192, 0)">can be combined</span> as long as the <span style="color:rgb(255, 192, 0)">Determinant is the same.</span>
> ![[Pasted image 20251104141051.png]]

<span style="color:rgb(146, 208, 80)">Transitivity</span>
> Functional dependencies are <span style="color:rgb(255, 192, 0)">transitive</span>. If A -> B and B -> C, then A -> C as well.

<span style="color:rgb(146, 208, 80)">Pseudo-transitivity</span>
> ![[Pasted image 20251104141242.png]]

### Summary
![[Pasted image 20251105094313.png]]
