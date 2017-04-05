/* @pjs preload="data/image.jpg"; */

//©Byungwook Yoon

PImage originalImage;
PImage editedImage;

int windowWidth = 400;
int windowHeight = 400;



void setup() {
  frameRate(100);
  size(windowWidth, windowHeight);

  originalImage = loadImage("data/image.jpg");

  windowWidth = originalImage.width;
  windowHeight = originalImage.height;
  image(originalImage, 0, 0);
}

void draw() {
  loadPixels();

  color colorSwap = pixels[windowWidth-1];
  color colorSwap2 = pixels[(windowHeight-1)*windowHeight];
  color colorSwap3 = pixels[(windowWidth-1) + (windowHeight-1)*windowHeight];
  color tempSwap;

  for (int i=0; i<windowHeight; i++) {

    if (i%2==0) {
      colorSwap = pixels[(windowWidth-1) + i*windowWidth];
      colorSwap3 = pixels[(windowWidth-1) + (i+1)*windowWidth];
      for (int j=windowWidth-1; j>0; j--) {
        tempSwap = pixels[j + i*windowWidth];
        pixels[j + i*windowWidth] = pixels[(j-1) + i*windowWidth];
        pixels[(j-1) + i*windowWidth] = tempSwap;
      }
      pixels[i*windowWidth] = colorSwap2;
    }

    else {
      colorSwap2 = pixels[i*windowWidth];
      for (int j=0; j<windowWidth-2; j++) {
        tempSwap = pixels[j + i*windowWidth];
        pixels[j + i*windowWidth] = pixels[(j+1) + i*windowWidth];
        pixels[(j+1) + i*windowWidth] = tempSwap;
        if (j>=windowWidth-3) {
          pixels[(j+1) + i*windowWidth] = colorSwap3;
        }
      }
      pixels[(windowWidth-1) + i*windowWidth] = colorSwap;
    }
  }


  updatePixels();
}

void mouseReleased() {
  originalImage = loadImage("image.jpg");
  editedImage = createImage(windowWidth, windowHeight, RGB);
  image(originalImage, 0, 0);
}

