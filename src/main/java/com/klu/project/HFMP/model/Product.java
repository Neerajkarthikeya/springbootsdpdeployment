package com.klu.project.HFMP.model;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob; // for handling the Blob object

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;
import java.util.Base64; // for Base64 encoding

@Entity
@Table(name = "product_table")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private int pid;

    @Column(name = "product_name", nullable = false, length = 100)
    private String pname;

    @Column(name = "product_desc", nullable = false, length = 500)
    private String pdescription;

    @Column(name = "product_cost", nullable = false)
    private double pcost;

    @Lob
    @Column(name = "product_image", nullable = false)
    private Blob image; // Blob for storing the binary data of the image

    // Getters and Setters
    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getPdescription() {
        return pdescription;
    }

    public void setPdescription(String pdescription) {
        this.pdescription = pdescription;
    }

    public double getPcost() {
        return pcost;
    }

    public void setPcost(double pcost) {
        this.pcost = pcost;
    }

    public Blob getImage() {
        return image;
    }

    public void setImage(Blob image) {
        this.image = image;
    }

    // Convert Blob image to Base64 encoded string
    public String getBase64Image() {
        if (image != null) {
            try (InputStream inputStream = image.getBinaryStream();
                 ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
                byte[] buffer = new byte[1024];
                int length;
                while ((length = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, length);
                }
                byte[] imageBytes = outputStream.toByteArray();
                return Base64.getEncoder().encodeToString(imageBytes);
            } catch (Exception e) {
                e.printStackTrace(); // Consider logging this exception instead
            }
        }
        return null;
    }
}
