# 🎸 Lyrics (demo). Using ShazamKit and lyrics.ovh API.

It's music time! Are you turning that song over and over in your head all the time? Did you just hear it play on the radio? I have a notice for you. Some time ago Apple bought the Shazam app and has included it as a framework for us (the army of programmers). Now with ShazamKit we can implement a routine to record the music we hear using the iPhone's microphone and then process it with ShazamKit to recognize unique signatures in the audio and determine the song title and artist. Magic right?

> **Disclaimer:** This implementation is just for educational purposes and for my own programming practice.

![Lyrics demo](lyrics-demo.gif)

## SOLID Principles
The development of the project was carried out based on the principles of single responsibility of high cohesion and low coupling, collected as SOLID principles of software engineering. 

## Architecture
Designed in a multilayer architecture, which constitutes an object-oriented system organized in several layers or levels. Each of these layers or levels contains a set of classes with responsibilities related to the layer to which they belong.  

## Architecture pattern
To take advantage of these advantages, I have relied on the SwiftUI language for the implementation of the presentation layer, as well as the architecture pattern: **Model-View-ViewModel (MVVM)** that allowed me to exploit its full potential.
